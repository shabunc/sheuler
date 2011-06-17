#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function f(n) 
    for j = 1, math.huge do 
        local m = j * n
        local digs = numeric.digits(m)
        if array.every(digs, function(d) return d <3 end) then
            return m, j
        end
    end
end

function test(m)
    local digs = numeric.digits(m)
    return array.every(digs, function(d) return d < 3 end) and m
end

function fim(n)
    for j = 1, math.huge do 
        local m = test(j*n)
        if m then
            return m, j
        end
    end
end

function fdiad(n) 
    local b = bignum({0},3) 
    while true do
        b = b:add(bignum({1},3))
        local m = numeric.number(b)
        if m % n == 0 then
            return m, m/n
        end
    end
end

function ff(n, func)
    local total = 0
    for j = 1, n do
        local _, k = func(j)
        print(string.format("%i %i %i", j, k, _))
        total = total + k
    end
    return total
end

assert(ff(100, fim) == 11363107)
--print("TOTAL", string.format("%i",ff(10000)))
