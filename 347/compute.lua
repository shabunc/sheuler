#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
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
        local count = 1
        while sieve[1] and sieve[1] * sieve[1] <= n do
            local p = table.remove(sieve, 1)
            coroutine.yield(p, count)
            local j = 1
            while j <= #sieve do
                if sieve[j] % p == 0 then
                    table.remove(sieve, j)
                else
                    j = j + 1
                end
            end
            count = count + 1
        end
        for j = 1, #sieve do
            coroutine.yield(sieve[j], j + count - 1)
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
    while true do
        local p, n = it()
        if not p then
            break
        end
        pr[n] = p
        for j = 1, n - 1 do
            if pr[j] * p > max then
                break
            end
            local sum = hammax(max, pr[j], pr[n])
            total = total + sum
            print(pr[j], p, sum, total)
        end
    end
    print("TOTAL", total)
    return total
end

assert(problem347(100) == 2262)
problem347(10000000)

