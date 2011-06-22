#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function problem187(max)
    local a, b
    local total = 0
    for i = 1, math.huge do
        if i >= max/numeric.prime(i) then
            break
        end
        for j = i, math.huge do
            a, b = numeric.prime(i), numeric.prime(j)
            if a * b >= max then
                break
            end
            total = total + 1
            print(a, b, a * b)
        end
    end
    return total
end

assert(problem187(30) == 10)
print("TOTAL", problem187(10^8))
