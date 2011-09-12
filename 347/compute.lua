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

function divs(n) 
    local function gen()
        for j = 2, math.sqrt(n) do
            local count  = 0 
            while n % j == 0 do
                n = n / j
                count = count + 1
            end
            if count > 0 then
                coroutine.yield(j, count)
            end
        end
        if n > 1 then
            coroutine.yield(n, 1)
        end
    end
    local it = coroutine.wrap(function() return gen() end)
    return function() 
        return it()
    end
end

function sum(t)
    local res = 0
    for j = 1, #t do
        res = res + t[j]
    end
    return res
end


function hams(max)
    local sieve = {}
    local found = {}
    for n = max, 6, -1 do
        if sieve[n] ~= false then
            local as = {}
            local ps = {}
            for p, a in divs(n) do
                table.insert(as, a)
                table.insert(ps, p)
                if #as > 2 then
                    break
                end 
            end
            if #as == 2 then
                print(n)
            end
        end
    end
    return found
end

function problemo(max)
    local res = sum(hams(max))
    return res
end

problemo(100)
