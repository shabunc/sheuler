#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")
require("bignum")

function problem56(n, m) 
    local max = 0
    for a = 1, n do
        for b = 1, m do
            local biga = bignum(numeric.digits(a)):pow(b)
            local sum = array.reduce(biga, function(a,b)return a + b end)
            if sum > max then
                print("new max", a, b, "=>", sum)
                max = sum
            end
        end
    end
    print("MAX", max)
    return max
end

print(problem56(100, 100))
