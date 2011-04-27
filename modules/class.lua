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

function class:add_metas(instance)
    local mt = getmetatable(instance)
    mt.__eq = instance.__eq
    mt.__tostring = instance.__tostring
end

function class:init()end
function class:__eq()end

function class:new(...) 
    local parent = select(2) or self
    local res = {}
    setmetatable(res, {})
    parent:inherit(res)
    parent:add_metas(res)
    res:init(...)
    return res
end

return class
