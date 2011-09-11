#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
require("array")

function log(a, b)
    return math.log(a) / math.log(b)
end

local PRIME = {}

function primes(n)
    local sieve = {}
    for j = 2, n do
        table.insert(sieve, j)
    end
    local res = {}
    local pindex = 1
    while sieve[pindex] and sieve[pindex] * sieve[pindex] <= n do
        local p = sieve[pindex]
        local lsieve = {}
        for j = 1, #sieve do
            if j <= pindex or sieve[j] % p ~= 0 then
                table.insert(lsieve, sieve[j])
            end
        end
        sieve = lsieve
        pindex = pindex + 1
    end
    return sieve
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

--print(hammax(100, 2, 3))
--print(hammax(10000000, 3, 5))
print(#primes(1000000))

