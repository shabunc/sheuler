#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("pascal")

function brute(n) 
    return (array.reduce(numeric.num2digits(numeric.factorial(n)), function(a, b) return a + b end))
end

function skip_tens(n) 
    local two_awaiting
    local five_awaiting
    local res = {}
    for j = 1, n do
        table.insert(res, j)
        if j % 5 == 0 then
            five_awaiting = j
        end
        if j % 2 == 0 then
            two_awaiting = j
        end
        if five_awaiting and two_awaiting then
            res[five_awaiting] = res[five_awaiting] / 5
            res[two_awaiting] = res[two_awaiting] / 2
            five_awaiting, two_awaiting = false, false
        end
    end
    local prod = array.reduce(res, function(a, b) return a * b end, 1)
    return array.reduce(numeric.num2digits(prod), function(a, b) return a + b end)
end

local n = 100
print(skip_tens(n), brute(n))
