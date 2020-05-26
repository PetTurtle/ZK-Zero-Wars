local Rect = {}
Rect.__index = Rect

function Rect.new(x, z, width, height)
    local instance = {
        x = x,
        z = z,
        width = w,
        height = h,
        buildMask = {
            x = math.floor(x / 16),
            y = math.floor(z / 16),
            width = math.floor(w / 16),
            height = math.floor(h / 16)
        }
    }
    setmetatable(instance, Rect)
    return instance
end

function Rect:setBuildMask(mask)
    local bm = self.buildMask
    for x = bm.x, bm.x + bm.width do
        for z = bm.z, bm.z + bm.height do
            Spring.SetSquareBuildingMask(x, z, mask)
        end
    end
end

function Rect:setBuildMaskOutline(mask)
    local bm = self.buildMask
    for x = bm.x, bm.x + bm.width do
        Spring.SetSquareBuildingMask(x, bm.z - 1, mask)
    end
    for x = bm.x, bm.x + bm.width do
        Spring.SetSquareBuildingMask(x, bm.z + bm.height + 1, mask)
    end
    for z = bm.z, bm.z + bm.height do
        Spring.SetSquareBuildingMask(bm.x - 1, z, mask)
    end
    for z = bm.z, bm.z + bm.height do
        Spring.SetSquareBuildingMask(bm.x + bm.width + 1, z, mask)
    end

    Spring.SetSquareBuildingMask(bm.x - 1, bm.z - 1, mask)
    Spring.SetSquareBuildingMask(bm.x + bm.width + 1, bm.z - 1, mask)
    Spring.SetSquareBuildingMask(bm.x - 1, bm.z + bm.height + 1, mask)
    Spring.SetSquareBuildingMask(bm.x + bm.width + 1, bm.z + bm.height + 1, mask)
end

function Rect:hasPoint(x, z)
    local x2, z2 = self:getBottomRight()
    return x > self.x and x < x2 and z > self.z and z < z2
end

function Rect:getTopLeft()
    return self.x, self.z
end

function Rect:getBottomRight()
    return self.x + self.width, self.z + self.height
end

function Rect:getCenter()
    return self.x + (self.width / 2), self.z + (self.height / 2)
end

return Rect