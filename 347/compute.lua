#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
require("numeric")
require("array")

function log(a, b)
    return math.log(a) / math.log(b)
end



function primes(n)
    return coroutine.wrap(function() 
        local sieve = {2}
        for j = 3, n, 2 do
            table.insert(sieve, j)
        end
        local pindex = 1
        while true do
            while sieve[pindex] == 0 do
                pindex = pindex + 1
            end
            local p  = sieve[pindex]
            if not p or p * p > n then
                for j = pindex, #sieve do
                    if sieve[j] > 0 then
                        coroutine.yield(sieve[j])
                    end
                end
                return
            end
            coroutine.yield(p)
            for j = pindex + 1, #sieve do
                if sieve[j] % p == 0 then
                    sieve[j] = 0
                end
            end
            pindex = pindex + 1
        end
    end)
end

function hammax(n, p, q)
    local i = math.floor(n / p)
    local j = math.floor(n / q)
    while true do
        local a = p * i
        local b = q * j
        if a > b then
            i = i - 1
        elseif a < b then
            j = j - 1
        else
            while a % p == 0 do
                a = a / p
            end
            while a % q == 0 do
                a = a / q
            end
            if a == 1 then
                return  p * i
            else
                i = i - 1
                j = j - 1
            end
        end
    end
end

function problem347(max)
    local it = primes(max)
    local res = {}
    local pr = {}
    local total = 0
    local n = 1
    while true do
        local p = it()
        if not p then
            break
        end
        pr[n] = p
        for j = 1, n - 1 do
            if pr[j] * p <= max then
                local sum = hammax(max, pr[j], p)
                total = total + sum
                print(p, pr[j], string.format("%i", total))
            else
                break
            end
        end
        n = n + 1
    end
    print("TOTAL", string.format("%i", total))
    return total
end

function problem(max)
    for j = max, 6, -1 do
        local divs = numeric.divisors(j)
        print(j, #divs)
    end
end

--assert(problem347(100) == 2262)
problem(100000)
