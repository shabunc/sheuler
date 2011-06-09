#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")


function brute72(d)
    local total = 0
    for b = d, 2, -1 do
       for a = 1, b - 1 do
            if numeric.are_rel_numeric.prime(a,b) then
                total = total + 1
                --print(a, b, numeric.are_rel_numeric.prime(a, b))
            end
       end
    end
    return total
end

function problem72(n)
    total = 0
    for d = 2, n do
        print(d)
        total = total + numeric.totient(d)
    end
    return total
end

assert(problem72(8), 21)

print("TOTAL", problem72(10^6))
