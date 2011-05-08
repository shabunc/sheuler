#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function problem69brute(lim)
    local max = -1
    local n
    for j = 2, lim do
       local r = numeric.totient(j) / j
       if r > max then
            print(j)
            max, n = r, j
       end  
    end
    print("MAX", max)
    print("N", n, numeric.divisors(n))
    return max
end

function problem69(lim)
    local n = lim
    while true do
        if numeric.is_prime(n) then
            print("PHI", numeric.totient(n)/n)
            print("N", n)
            return n
        end
        n = n - 1
    end
end

problem69(1000000)

