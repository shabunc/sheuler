#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")

function problem72(d)
    local lookup = {}
    local total = 0
    for b = d, 2, -1 do
       for a = 1, b - 1 do
            if numeric.are_rel_primes(a,b) then
                total = total + 1
                print(a, b, numeric.are_rel_primes(a, b))
            end
       end
    end
    return total
end

assert(problem72(8), 21)

print(problem72(10^6))
