#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function func(a, b, c) 
    return numeric.prime(a)^2 + numeric.prime(b)^3 +numeric.prime(c)^4
end

function find_largest(max, func)
    for n = 3, math.huge do
        if (numeric.prime(n) ^ 2) > max then
            return n
        end
    end
end

function find_all(max)
    local pmax = find_largest(max) 
    local total = 0
    for j = 1, pmax do
        for i = 1, pmax do
            for k = 1, pmax do
                if func(i,j,k) <= max then
                    total = total + 1
                end
            end
        end
    end
    return total
end

assert(find_all(50) == 4)
print("TOTAL", find_all(50 * 10^6))
