#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("permutations")

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

function prime_set(n)
    local lex = perm.lexicographic_iterator({1,2,3,4,5,6,7,8,9})
    while true do
        local seq = lex()
        if not seq then
            break
        end
        local parts = numeric.partitions_iterator(n, {9,8,7,6,5,4,3,2,1})
        while true do 
            local part = parts()
            if not part then
                break
            end
            print(seq)
        end
    end
end

prime_set(5)

--[[
problem118(9, {9,8,7,6,5,4,3,2,1})
problem118(8, {9,8,7,6,5,4,3,2,1})
problem118(7, {9,8,7,6,5,4,3,2,1})
problem118(6, {9,8,7,6,5,4,3,2,1})
problem118(5, {9,8,7,6,5,4,3,2,1})
]]
