#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function fraction(a, b)
    local h = numeric.HCF(a, b)
    return a / h, b / h
end

function mul(a, b, c, d) 
    return fraction(a * c, b * d)
end

print(mul(1,2,3,10))
