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
    --[[
    for n = max, 2, -1 do
       local ns = get_fractions(n) 
       for j = 1, #ns do
            table.insert(res, ns[j])
       end
    end
    ]]
    for j = 2, max do
        for i = j - 1, 1, -1 do
            if numeric.are_rel_primes(i, j) then
                table.insert(res, fraction(i, j))
            end
        end
    end
    table.sort(res, function(a, b)
        return a.a * b.b  < b.a * a.b
    end)
    return res
end

function problem71(max)
    local all = get_all_fractions(max)
    local find = all[array.index_of(all, function(i, v) return v.a == 3 and v.b  == 7 end) - 1]
    print(find)
end

assert(#get_all_fractions(8) == 21)

problem71(10^3)

