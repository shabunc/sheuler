#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("bignum")
memoize = require("memoize")

function penta1(q)
    return q * (3 * q - 1) / 2
end

function penta2(q)
    return q * (3 * q + 1) / 2
end

function P(n)
    if n < 0 then 
        return 0 
    end
    if n == 0 or n == 1 then
        return 1
    end
    local sum = 0
    for j = 1, math.huge do
        local k1, k2 = penta1(j), penta2(j)
        local pair = P(n - k1) + P(n - k2)
        if pair == 0 then
            return sum
        end
        if j % 2 == 0 then
            pair = -pair
        end
        sum = sum + pair
    end
end 
P = memoize(P)

print(P(100))
