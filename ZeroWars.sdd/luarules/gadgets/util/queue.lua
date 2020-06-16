Queue = {}
Queue.__index = Queue

function Queue.new()
    local instance = {
        _first = 0,
        _last = -1,
        _list = {}
    }
    setmetatable(instance, Queue)
    return instance
end

function Queue:push(value)
    self._first = self._first - 1
    self._list[self._first] = value
end

function Queue:pop()
    if self._first > self._last then
        error("list is empty")
    end
    local value = self._list[self._last]
    self._list[self._last] = nil
    self._last = self._last - 1
    return value
end

function Queue:peek()
    if self._first > self._last then
        error("list is empty")
    end
    return self._list[self._last]
end

function Queue:size()
    return self._last - self._first + 1
end

return Queue