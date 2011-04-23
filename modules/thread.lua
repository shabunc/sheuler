--[[
    local iterator = thread.wrap(something)
    while iterator.alive() do
        local item = iterator()
        ...
    end
]]

thread = {}

local function wrap(func)
    local co = coroutine.create(func)
    local callfunc = function(...)
        return select(2, coroutine.resume(co,...))
    end
    local mt = {
        __call = callfunc
    }
    local res = {
        dead = function() 
            return coroutine.status(co) == "dead"
        end
    }
    setmetatable(res, mt)
    return res
end

thread.wrap = wrap
return thread
