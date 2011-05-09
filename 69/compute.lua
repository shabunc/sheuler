#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function problem69brute(lim)
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

function problem69(len)
    local primes = {2} 
    local n = 3
    while true do
        if numeric.is_prime(n) then
            local pr = array.reduce(primes, function(a, b) return a*b end, 1)
            if pr * n > len then
                print("RES", pr, numeric.divisors(pr))
                return pr
            end
            table.insert(primes, n)
        end
        n = n + 2
    end
end

problem69(1000000)
