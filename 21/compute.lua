#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function d(a)
    local divs = numeric.alldivisors(a)
    table.remove(divs)
    return array.reduce(divs, function(a, b) return a + b end)
end

function isamicable(a,b)
    local b = d(a)
    if a == b then
        return false
    end
    return d(b) == a, b
end

function problem21(n)
    local total = 0
    local sum = 0
    for j = 1, n do
        local is_amicable = isamicable(j)
        if is_amicable then
            print(j)
            total = total + 1
            sum = sum + j
        end
    end
    print("TOTAL", total)
    print("SUM", sum)
    return total
end

problem21(10000)
