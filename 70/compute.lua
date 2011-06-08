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
    while primes(k) <= n do 
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

function alldivisors(n)
    local all = {}
    local divs = divisors(n)
    local m = n
    for _, div in ipairs(divs) do
        local deg = 0
        while m % div == 0 do
            m = m / div
            deg = deg + 1
        end
        table.insert(all, {div, deg})
    end
    if #all == 0 then
        table.insert(all, {n, 1})
    end
    return all
end

function totient(n)
   if n == 1  then
        return 1
   end 
   local alls = alldivisors(n) 
   local total = 1
   for _, v in ipairs(alls) do
        total = total * (v[1] ^ v[2] - v[1] ^ (v[2] - 1))
   end
   return total
end

assert(totient(87109) == 79180)

function problem70(n)
    for j = 1, n do
        local phi = totient(j)
        local a = array(numeric.digits(j))
        table.sort(a)
        local b = array(numeric.digits(phi))
        table.sort(b)
        if a == b then
            print(j, phi, j/phi)
        end
    end
end

problem70(10^3)

