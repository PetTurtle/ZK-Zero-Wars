PlatformClones = {}
PlatformClones.__index = PlatformClones

function PlatformClones:Create()
    local o = {}
    setmetatable(o, PlatformClones)


    return o
end

function PlatformClones:NewClones(clones, originals)

end

