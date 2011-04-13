#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function problem56(n) 
    local max = 0
    for a = 1, n do
        for b = 1, n do
            local sum = array.reduce(numeric.num2digits(a^b),function(a,b)return a + b end)
            if sum > max then
                print(sum, a^b, a, b)
                max = sum
            end
        end
    end
    return max
end

print(problem56(10,10))
