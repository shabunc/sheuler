#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function reduce(a, b)
    local h = numeric.HCF(a, b)
    return a / h, b / h
end

--a / (math.sq(b) + c)
function step(a, b, c)
    local bb = b
    local cc = -c
    local dd = reduce(b  - c ^ 2, a)
    local nearest = math.floor(math.sqrt(b))
    local rem = 0
    local diff
    repeat
       rem = rem + 1
       diff = cc - dd * rem
       print("rem search", cc, rem, rem * dd, math.abs(cc - dd * rem), nearest)
    until rem == 10
    return rem, dd, bb, diff
end

print(step(7, 23, -3))
