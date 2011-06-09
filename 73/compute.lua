#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("class")
require("iterator")

fraction = class:new()

function fraction:init(a, b) 
    self.a = a
    self.b = b
end

function fraction:__tostring()
    return "" .. self.a .. "/" .. self.b
end

function get_fractions(d)
    local res = {}
    for a = d - 1, 1, -1 do
        if numeric.are_rel_primes(a, d) then
            table.insert(res, fraction(a, d))
        end
    end
    return res
end

function get_all_fractions(max)
    local res = {}
    for n = max, 2, -1 do
       local ns = get_fractions(n) 
       print(n)
       for j = 1, #ns do
            table.insert(res, ns[j])
       end
    end
    table.sort(res, function(a, b)
        return a.a * b.b  < b.a * a.b
    end)
    setmetatable(res, {
        __tostring = function() 
            local s = ""
            for j = 1, #res do
                s = s .. " " .. tostring(res[j])
            end
            return s
        end
    })
    return res
end

function problem73(max)
    local all = get_all_fractions(max)
    print(all)
end


problem73(12000)

