#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")

primes = (function() 
    local max = 3
    local primeslookup = {2, 3}

    local function is_prime(n) 
        local test = true
        for j = 1, math.sqrt(n) do
            if n % primeslookup[j] == 0 then
                test = false
                break
            end
        end
        return test
    end

    return function(n) 
       if n <= #primeslookup then
            return primeslookup[n]
       end
       m = primeslookup[#primeslookup] + 2
       while #primeslookup ~= n do
            if is_prime(m) then
                table.insert(primeslookup, m)
            end
            m = m + 2
       end
       return primeslookup[n]
    end
end)()

function divisors(n) 
    local k = 1
    local divs = {}
    while primes(k) <= n/2 do 
        if n % primes(k) == 0 then
            table.insert(divs, primes(k))
        end
        k = k + 1
    end
    if #divs == 0 then
        table.insert(divs, n)
    end
    return divs
end

function totient(n, divs)
   if n == 1  then
        return 1
   end 
   local divs = divs or divisors(n) 
   res = n 
   for _, p in ipairs(divs) do
        res = res/p
        res = res * (p - 1)
   end 
   return res 
end

function brute72(d)
    local lookup = {}
    local total = 0
    for b = d, 2, -1 do
       for a = 1, b - 1 do
            if numeric.are_rel_primes(a,b) then
                total = total + 1
                --print(a, b, numeric.are_rel_primes(a, b))
            end
       end
    end
    return total
end

function problem72(n)
    total = 0
    for d = 2, n do
        print(d)
        total = total + totient(d)
    end
    return total
end

assert(problem72(8), 21)

print("TOTAL", problem72(10^6))
