Queue = {}
Queue.__index = Queue

function Queue:New()
    local o = {}
    setmetatable(o, Queue)
    o.first = 0
    o.last = -1
    o.list = {}
    return o
end

function Queue:PushLeft(value)
    self.first = self.first - 1
    self.list[self.first] = value
end

function Queue:PushRight(value)
    self.last = self.last + 1
    self.list[self.last] = value
end

function Queue:PopLeft()
    if self.first > self.last then
        error("list is empty")
    end
    local value = self.list[self.first]
    self.list[self.first] = nil
    self.first = self.first + 1
    return value
end

function Queue:PopRight()
    if self.first > self.last then
        error("list is empty")
    end
    local value = self.list[self.last]
    self.list[self.last] = nil
    self.last = self.last - 1
    return value
end

function Queue:PeekLeft()
    if self.first > self.last then
        error("list is empty")
    end
    return self.list[self.first]
end

function Queue:PeekRight()
    if self.first > self.last then
        error("list is empty")
    end
    return self.list[self.last]
end

function Queue:Size()
    return self.last - self.first
end

return Queue
