local spSetSquareBuildingMask = Spring.SetSquareBuildingMask

Rect = {}
Rect.__index = Rect

function Rect.new(x, z, w, h)
    local instance = {
        _x = x,
        _z = z,
        _w = w,
        _h = h,
        _mbX = math.floor(x / 16), -- buildMaskX
        _mbZ = math.floor(z / 16), -- buildMaskZ
        _mbW = math.floor(w / 16), -- buildMask width
        _mbH = math.floor(h / 16) -- buildMask height
    }
    setmetatable(instance, Rect)
    return instance
end

function Rect:getX()
    return self._x
end

function Rect:getZ()
    return self._z
end

function Rect:getX2()
    return self._x + self._w
end

function Rect:getZ2()
    return self._z + self._h
end

function Rect:contains(x, z)
    return x > self._x and x < self:getX2() and z > self._z and z < self:getZ2()
end

function Rect:getOffset(rect)
    return {x = (rect:getX() - self._x), z = (rect:getZ() - self._z)}
end 

function Rect:getCenter()
    local centerX = self._x + ((self:getX2() - self._x) / 2)
    local centerZ = self._z + ((self:getZ2() - self._z) / 2)
    return centerX, centerZ
end

function Rect:setBuildMask(mask)
    for x = self._mbX, self._mbX + self._mbW do
        for z = self._mbZ, self._mbZ + self._mbH do
            spSetSquareBuildingMask(x, z, mask)
        end
    end
end

function Rect:setOutlineBuildMask(mask)
    for x = self._mbX, self._mbX + self._mbW do
        spSetSquareBuildingMask(x, self._mbZ - 1, mask)
    end
    for x = self._mbX, self._mbX + self._mbW do
        spSetSquareBuildingMask(x, self._mbZ + self._mbH + 1, mask)
    end
    for z = self._mbZ, self._mbZ + self._mbH do
        spSetSquareBuildingMask(self._mbX - 1, z, mask)
    end
    for z = self._mbZ, self._mbZ + self._mbH do
        spSetSquareBuildingMask(self._mbX + self._mbW + 1, z, mask)
    end

    spSetSquareBuildingMask(self._mbX - 1, self._mbZ - 1, mask)
    spSetSquareBuildingMask(self._mbX + self._mbW + 1, self._mbZ - 1, mask)
    spSetSquareBuildingMask(self._mbX - 1, self._mbZ + self._mbH + 1, mask)
    spSetSquareBuildingMask(self._mbX + self._mbW + 1, self._mbZ + self._mbH + 1, mask)
end

return Rect
