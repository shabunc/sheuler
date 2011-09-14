#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
require("numeric")
require("array")
require("bignum")

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
                --print(p, pr[j], sum, string.format("%i", total))
                --print(p, pr[j], sum)
            else
                break
            end
        end
        n = n + 1
    end
    --print("TOTAL", string.format("%i", total))
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
    local res = bignum{0}
    for j = 1, #t do
        res = res:add(bignum(numeric.digits(t[j])))
    end
    return res
end


function num(ps, as)
    local res = 1
    for j = 1, #ps do
        res = res * ps[j]^as[j]
    end
    return res
end

function dec(template)
    local t = {}
    for j = 1, #template do
        table.insert(t, template[j])
    end
    return function() 
        local k = #t
        while k > 0 and t[k] == 0 do
            k = k - 1
        end
        if k == 0 then
            return
        end
        t[k] = t[k] - 1
        for j = #t, k + 1, - 1 do
            t[j] = template[j]
        end
        local parts = 0
        return t
    end
end

function hams(max)
    local sieve = {}
    local found = {}
    local filtered = {}
    for n = max, 6, -1 do
        if sieve[n] ~= false then
            --print(n)
            local ps = {}
            local as = {}
            for p, a in divs(n) do
                table.insert(ps, p)
                table.insert(as, a)
            end
            if #ps == 2 then
                local key = ps[2] .. " " ..  ps[1]
                if not filtered[key] then
                    --print(ps[2], ps[1], n)
                    table.insert(found, n)
                    filtered[key] = true
                end
            end
            for a in dec(as) do
                local parts = #a
                for j = 1, #a do
                    if a[j] == 0 then
                        parts = parts - 1
                    end
                end
                if parts ~= 2 then
                    local m = num(ps, a)
                    sieve[m] = false
                end
            end
        end
    end
    return found
end

function problemo(max)
    local found = hams(max)
    return sum(found)
end

function S(n)
    if n < 6 then 
        return 0
    end
    local ps = {}
    local as = {}
    local wrong_for_sure = false
    for p, a in divs(n) do
        table.insert(ps, p)
        table.insert(as, a)
        if #ps > 2 then
            wrong_for_sure = true
            break
        end 
    end
    if not wrong_for_sure and #ps == 2 then
        local dec
        if as[1] == 1 and as[2] == 1 then
            dec = 0 
        elseif as[1] == 1 and as[2] ~= 1 then
            dec = math.max(n / ps[2])
        elseif as[1] ~=1 and as[2] == 1 then
            dec = n / ps[1]
        else 
            dec = math.max(n / ps[1], (n / ps[1]) * ps[2])
        end
        return S(n - 1) + n - dec
    else
        return S(n - 1)
    end
end

for j = 1, 20 do
    print(j, S(j), problemo(j))
end
