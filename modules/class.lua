class = {}

--[[
    to create a class, just write ClassA = class:new()
    to create ClassB, which inherits from ClassA, just write ClassB = ClassA:new()
    and redefine some properties. 

    the logic is pretty same as in javascript implementation of prototype inheritance
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
    res:init(...)
    return res
end

return class
