#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function get_primes(n) 
    local res  = {2}
    for j = 3, n, 2 do
        if numeric.is_prime(j) then
            table.insert(res, j)
        end
    end
    return res
end

function count(n) 
   local it = numeric.partitions_iterator(n, get_primes(n)) 
   local total = 0
   while true do
        local seq = it()
        if not seq then
            break
        end
        total = total + 1
   end
   return total
end

function problem77(lim)
    local n = 3
    while true do
        print(n, count(n))
        if count(n) >= lim then
            return n
        end
        n = n + 1
    end
end

print(problem77(5000))
