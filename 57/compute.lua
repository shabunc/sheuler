#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("fraction")

local ONE = fraction(1, 1)

function step(fr)
    return fraction(fr.a + 2 * fr.b, fr.a + fr.b):reduce()
end

function numlen(n)
    return math.floor(math.log10(n)) + 1
end

function good_one(fr) 
    if fr.b >= fr.a then
        return false
    end
    if numlen(fr.b) >= numlen(fr.a) then
        return false
    end
    return true
end

function problem57(n)
    local fr = fraction(1, 1)
    local total = 0
    for j = 1, n do 
        fr = step(fr)
        local passed = good_one(fr)
        print(j, string.format("%i %i", fr.a, fr.b), passed)
        if passed then
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end

problem57(1000)
