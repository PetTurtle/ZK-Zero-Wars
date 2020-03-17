include("LuaRules/Configs/customcmds.h.lua")

Clones = {}
Clones.__index = Clones

function Clones:Create()
    local o = {}
    setmetatable(o, Clones)
    o.clones = {}
    o.inactive = {}
    return o
end

function Clones:NewClones(clones, originals)
    assert(#clones == #originals)

end

return Clones