#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("fraction")
require("bigint")

local ONE = fraction(1, 1)

function step(fr)
    return fraction(fr.a + 2 * fr.b, fr.a + fr.b):reduce()
    --return fr:add(ONE):recip():add(ONE)
end

function numlen(n)
    return math.floor(math.log10(n)) + 1
end

function good_one(fr) 
    return numlen(fr.a) > numlen(fr.b)
end

function problem57(n)
    local fr = fraction(1, 1)
    local total = 0
    for j = 1, n do 
        fr = step(fr)
        local passed = good_one(fr)
        if passed then
            print(j, string.format("%i %i", fr.a, fr.b), passed)
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end

problem57(1000)
