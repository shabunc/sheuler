#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function smallest(n)
    local p1 = numeric.prime(n)
    local p2 = numeric.prime(n + 1)
    local numlen = math.floor(math.log10(p1)) + 1
    for j = 1, math.huge do
        local m = j * 10 ^ numlen + p1
        if m % p2 == 0 then
            return m
        end
    end
end

function smallest2(n)
    local p1 = numeric.prime(n)
    local p2 = numeric.prime(n + 1)
    local numlen = math.floor(math.log10(p1)) + 1
    for  j = 1, math.huge do
        local m = j * p2
        if  (m - p1) % (10^numlen) == 0 then
            return m
        end
    end
end



function problem134(max, func)
    local total = 0
    for j = 3,  math.huge do
        local p = numeric.prime(j)
        if p > max then
            break
        end
        local sm = func(j)
        print(sm, p, numeric.prime(j+1))
        total = total + sm
    end
    print("TOTAL", total)
    return total
end

assert(smallest(8) == 1219)

problem134(10^6, smallest2)
