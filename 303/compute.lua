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

function fdiad(n) 
    local b = bignum({0},3) 
    while true do
        b = b:add(bignum({1},3))
        local m = numeric.number(b)
        if m % n == 0 then
            return n, m/n
        end
    end
end

function ff(n)
    local total = 0
    for j = 1, n do
        local _, k = fdiad(j)
        print(j, k)
        total = total + k
    end
    return total
end

assert(ff(100) == 11363107)
print("TOTAL", string.format("%i",ff(10000)))
