#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function problem69(lim)
    local max = -1
    local n
    for j = 2, lim do
       local r = j / numeric.totient(j)
       if r > max then
            --print(j)
            max, n = r, j
       end  
    end
    --print("MAX", max)
    --print("N", n, numeric.divisors(n))
    return n, max
end

function investigate(len)
    local max = -1
    for j = 2, len do
        local n = problem69(j)
        if n > max then
            max = n
            print(j, n, numeric.divisors(n))
        end
    end
end

investigate(5000)

