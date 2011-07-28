#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function sigma2(n)
    local sum = array.reduce(numeric.divisors(n), function(a, b) return a + b^2 end) 
    sum = 1 + sum + n*n
    return sum
end

print(table.concat(numeric.divisors(36)))
