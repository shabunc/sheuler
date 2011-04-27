class = {}

--[[
    to create a class, just write ClassA = class:new()
    to create ClassB, which inherits from ClassA, just write ClassB = ClassA:new()
    and redefine some properties. 

    the logic is pretty same as in javascript implementation of prototype inheritance

    as for instances, we create them this way
    ClassA = class:new()
    a = ClassA(params)
    and you alsow should define :init method
]]

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
    mt.__call  = function(instance, ...)
        instance = instance:new()
        instance:init(...)
        return instance
    end
    return self
end

function class:add_metas()
    --NOTE that this methods should be defined BEFORE any instance creations
    local mt = getmetatable(self)
    mt.__eq = self.__eq
    mt.__tostring = self.__tostring
end

function class:init()end
function class:__eq()end
function class:__tostring() return "WRONG SERIALIZE"end

function class:new(...) 
    local res = {}
    setmetatable(res, {})
    self:inherit(res)
    res:add_metas()
    return res
end

return class
