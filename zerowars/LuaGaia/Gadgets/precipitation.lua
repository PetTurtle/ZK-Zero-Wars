--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--

function gadget:GetInfo()
  return {
    name      = "Precipitation",
    desc      = "Precipitation shader gadget",
    author    = "trepan, jK",
    date      = "2007-2011",
    license   = "GNU GPL, v2 or later",
    layer     = 10,
    enabled   = true
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Unsynced side only
if (gadgetHandler:IsSyncedCode()) then
  return false
end

-- Require shaders
if (not gl.CreateShader)or(not gl.PointParameter) then
  return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local enabled = false

local shader
local shaderWindLoc
local shaderTimeLoc
local shaderCamPosLoc
local shaderCamDirLoc
local shaderNeedLocs = true

local rainList
local particleList

local mapcfg

if VFS.FileExists("mapinfo.lua") then
	mapcfg = VFS.Include("mapinfo.lua")
else
	error("missing file: mapinfo.lua")
end

if (not mapcfg)or(not mapcfg.custom)or(not mapcfg.custom.precipitation) then
	error("Precipitation-Gadget: Can't find settings in mapinfo.lua!")
end

local conf = mapcfg.custom.precipitation

local DENSITY     = conf.density
local SCALE       = conf.size
local SPEED       = conf.speed
local TEXTURE     = conf.texture
local WIND_SCALE  = conf.windscale

assert(type(DENSITY) == "number")
assert(type(SCALE) == "number")
assert(type(SPEED) == "number")
assert(type(WIND_SCALE) == "number")
assert(type(TEXTURE) == "string")

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:Initialize()
  if (not ReloadResources()) then
    gadgetHandler:RemoveGadget()
    return
  end

  enabled = (Spring.GetMapOptions().weather == "snow")

  gadgetHandler:AddChatAction("rain", ChatAction,
    ':  [0|1]  [speed val]  [scale val]  [density val]  [texture name]'
  )
end


function gadget:Shutdown()
  FreeResources()
  gadgetHandler:RemoveChatAction("rain")
end


function ReloadResources()
  FreeResources()
  if ((not CreateParticleList()) or
      (not CreateRainList())     or
      (not CreateShader()))    then
    gadgetHandler:RemoveGadget()
    return false
  end
  return true
end


function FreeResources()
  gl.DeleteList(rainList)
  gl.DeleteList(particleList)
  if (gl.DeleteShader) then
    gl.DeleteShader(shader)
  end
  shader = nil
  rainList = nil
  particleList = nil
end


function ChatAction(cmd, line, words, player)
  --Spring.Echo(cmd,' : ',line ' : ',words, ':',player)
  if (player ~= 0) then
    Spring.Echo('Only the host can control the weather')
    return true
  end
  if (#words == 0) then
    enabled = not enabled
    Spring.Echo("rain is " .. (enabled and 'enabled' or 'disabled'))
    return
  end
  if (words[1] == '0') then
    enabled = false
    Spring.Echo("rain is disabled")
  elseif (words[1] == '1') then
    enabled = true
    Spring.Echo("rain is enabled")
  elseif (words[1] == 'scale') then
    local value = tonumber(words[2])
    if (value and (value > 0)) then
      SCALE = value
      ReloadResources()
    end
  elseif (words[1] == 'speed') then
    local value = tonumber(words[2])
    if (value) then
      SPEED = value
      ReloadResources()
    end
  elseif (words[1] == 'density') then
    local value = tonumber(words[2])
    if (value and (value > 0) and (value <= 1000000)) then
      DENSITY = value
      ReloadResources()
    end
  elseif (words[1] == 'texture') then
    if (type(words[2]) == 'string') then
      TEXTURE = words[2]
      ReloadResources()
    end
  end
  return true
end


function CreateParticleList()
  particleList = gl.CreateList(function()
    local tmpRand = math.random()
    math.randomseed(1)
    gl.BeginEnd(GL.POINTS, function()
      for i = 1, DENSITY do
        local x = math.random()
        local y = math.random()
        local z = math.random()
        local w = math.random()
        gl.Vertex(x, y, z, w)
      end
    end)
    math.random(1e9 * tmpRand)
  end)

  if (particleList == nil) then
    return false
  end
  return true
end


function CreateRainList()
  rainList = gl.CreateList(function()
    gl.Color(0, 0, 1, 1)

    gl.PointSprite(true, true)
    gl.PointSize(20.0)
    gl.PointParameter(0, 0, .001, 0, 1e9, 1)

    gl.DepthTest(true)
    --gl.Blending(GL.SRC_ALPHA, GL.ONE)
    gl.Texture(TEXTURE)

    gl.CallList(particleList)

    gl.Texture(false)
    gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    gl.DepthTest(false)

    gl.PointParameter(1, 0, 0, 0, 1e9, 1)
    gl.PointSize(1.0)
    gl.PointSprite(false, false)
  end)

  if (rainList == nil) then
    return false
  end
  return true
end


function CreateShader()
  shaderNeedLocs = true

  shader = gl.CreateShader({
    uniform = {
      time   = 0,
      scale  = SCALE,
      speed  = SPEED,
      camPos = { 0, 0, 0 },
    },
    vertex = [[
      uniform float time;
      uniform float scale;
      uniform float speed;
      uniform vec3 camDir;
      uniform vec3 camPos;
      uniform vec3 wind;

      void main(void)
      {
        const float boxSize = 800.;
        float hBoxSize = boxSize * 0.5;

        vec3 scalePos = vec3(gl_Vertex) * boxSize;
        vec3 eye = camPos;

        vec3 pos = scalePos - mod(camPos, boxSize);
        pos.y -= time * 0.5 * speed * (2.0 + gl_Vertex.w);
        pos.x += sin(time + scalePos.y) * 10. * gl_Vertex.w;
        pos.z += cos(time + scalePos.x) * 10. * gl_Vertex.w;
        pos += wind * 10.;
        pos = mod(pos, boxSize) - hBoxSize;

        //! move particles behind the camera to the front to not waste them
        float behind = max(-sign( dot(pos, camDir) ), 0.); //! either 0 (in front of camera) or 1 (behind camera) - we save a costly branch (if-clause) by using this factor!
	pos += behind * sign(camDir) * boxSize;

        pos += camPos;
	float origPosY = pos.y;
        pos.y = max(0., pos.y); //! make snow float on the water surface
        vec4 eyePos = gl_ModelViewMatrix * vec4(pos, 1.0);

        gl_PointSize = (1. + gl_Vertex.w) * scale * hBoxSize / length(eyePos.xyz);
        gl_FrontColor.rgb = vec3(0.75, 0.75, 0.80) + cos(scalePos.xyz) * 0.05;
        gl_FrontColor.a   = gl_Color.a * (1. - (camPos.y - origPosY) / boxSize);
        gl_Position = gl_ProjectionMatrix * eyePos;
      }
    ]],
    fragment = [[
      uniform sampler2D tex0;

      void main(void)
      {
        gl_FragColor = gl_Color * texture2D(tex0, gl_TexCoord[0].st);
      }
    ]],
    uniformInt = {
      tex0 = 0
    },
  })

  if (shader == nil) then
    print(gl.GetShaderLog())
    return false
  end
  return true
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function GetShaderLocations()
  shaderTimeLoc   = gl.GetUniformLocation(shader, 'time')
  shaderCamPosLoc = gl.GetUniformLocation(shader, 'camPos')
  shaderCamDirLoc = gl.GetUniformLocation(shader, 'camDir')
  shaderWindLoc   = gl.GetUniformLocation(shader, 'wind')
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local inWaterReflectionPass = false
local function spGetCameraDirection()
	local x,y,z = Spring.GetCameraDirection()
	if inWaterReflectionPass then
		return x, -y, z
	end
	return x, y, z
end

local function smoothstep(min,max,v)
	if (v<=min) then return 0.0; end
	if (v>=max) then return 1.0; end
	local t = (v - min) / (max - min);
	t = math.min(1.0, math.max(0.0, t ));
	return t * t * (3.0 - 2.0 * t);
end

local function blend(x,y,a)
	return x * (1-a) + y * a
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local next_upd = 0
local oldWindX, oldWindY, oldWindZ = 0,0,0
local windX, windY, windZ = 0,0,0
local oldWindOffset = 0

function gadget:DrawScreenEffects() --World()
  if (not enabled) then
    return
  end

  --local GL_DEPTH_WRITEMASK = 2930
  --Spring.Echo("GL_DEPTHWRITE", gl.GetNumber(GL_DEPTH_WRITEMASK, 1))

  gl.UseShader(shader)

  if (shaderNeedLocs) then
    GetShaderLocations()
    shaderNeedLocs = false
  end

  local gameFrame = Spring.GetGameFrame()

  if (next_upd <= gameFrame) then
    oldWindX = windX
    oldWindY = windY
    oldWindZ = windZ
    wx, wy, wz = Spring.GetWind()
    windX = windX + wx * WIND_SCALE
    windY = windY + wy * WIND_SCALE
    windZ = windZ + wz * WIND_SCALE
    next_upd = gameFrame + 210
    oldWindOffset = 0
  end

  local timeOffset = Spring.GetFrameTimeOffset() / 30
  gl.Uniform(shaderTimeLoc,   Spring.GetGameSeconds() + timeOffset)
  gl.Uniform(shaderCamPosLoc, Spring.GetCameraPosition())
  gl.Uniform(shaderCamDirLoc, spGetCameraDirection())

  windOffset = 1 - (next_upd - (gameFrame + timeOffset * 30)) / 210
  if (windOffset < oldWindOffset) then
    windOffset = oldWindOffset
  end
  oldWindOffset = windOffset
  windOffset = smoothstep(0, 1, windOffset)
  gl.Uniform(shaderWindLoc, blend(oldWindX, windX, windOffset), blend(oldWindY, windY, windOffset), blend(oldWindZ, windZ, windOffset))

  gl.MatrixMode(GL.PROJECTION); gl.PushMatrix(); gl.LoadMatrix("camprj")
  gl.MatrixMode(GL.MODELVIEW);  gl.PushMatrix(); gl.LoadMatrix("camera")

  gl.CallList(rainList)

  gl.MatrixMode(GL.PROJECTION); gl.PopMatrix()
  gl.MatrixMode(GL.MODELVIEW);  gl.PopMatrix()

  gl.UseShader(0)
end


function gadget:DrawWorldReflection()
	local camY = select(2, Spring.GetCameraPosition())
	if (camY < 350) and (camY > 0) then
		inWaterReflectionPass = true
			gadget:DrawScreenEffects()
		inWaterReflectionPass = false
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
