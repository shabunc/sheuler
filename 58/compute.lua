#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

-- see problem 28
require("numeric")
require("array")

function quasifib(n) 
    if n == 0 then
        return {1}
    end
    local prev = quasifib(n - 1)
    local from = prev[#prev] + 2*n 
    local res = {}
    for j = 0, 3 do
        table.insert(res, j * 2 * n + from)
    end
    return res
end

function problem58(lim)
    local total =  0
    local primes = 0
    for j = 0, math.huge do
        local seq = quasifib(j)
        total = total + #seq
        primes = primes + #array.filter(seq, function(p) return numeric.is_prime(p)  end)
        local ratio = primes / total
        print((j + 1) * 2 + 1, primes, total, ratio)
        if ratio > 0 and ratio < lim then
            break
        end
    end
    print(total, primes)
end

--[[
print(table.concat(quasifib(0)))
print(table.concat(quasifib(1)," "))
print(table.concat(quasifib(2)," "))
print(table.concat(quasifib(3)," "))
]]

problem58(0.1)
