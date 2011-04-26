class = {}

function class:inherit(instance)
    local mt = getmetatable(instance)
    mt.__index = function(instance, key) 
        local own = rawget(instance, key)
        if own then
            return own
        else
            return self[key]
        end 
    end
    return self
end

function class:init()end

function class:new(...) 
    local parent = select(2) or self
    local res = {}
    setmetatable(res, {})
    parent:inherit(res)
    res:init(...)
    return res
end

return class
