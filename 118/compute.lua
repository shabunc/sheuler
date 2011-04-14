#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

local primes = {[2] = 1}

function is_prime(n)
    for j = 3, math.sqrt(n), 2 do
    end
end

function problem118(n, t)
    local iterator = numeric.partitions_iterator(n, t, 1)
    local total = 0
    while true do
        local p = iterator()
        if not p then 
            break
        end
        local s = ""
        total = total + 1
        for i, v in ipairs(p) do
            s = s.." "..v[1].."*"..v[2] 
        end
        --print(s)
    end
    print(total)
    return total
end

problem118(9, {9,8,7,6,5,4,3,2,1})
problem118(8, {9,8,7,6,5,4,3,2,1})
problem118(7, {9,8,7,6,5,4,3,2,1})
problem118(6, {9,8,7,6,5,4,3,2,1})
problem118(5, {9,8,7,6,5,4,3,2,1})
