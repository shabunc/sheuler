#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

local CACHE = {}

function fib(n)
    if n == 1 then
        return 1
    end
    if n == 2 then
        return 2
    end
    if CACHE[n] then
        return CACHE[n]
    end
    --local res = fib(n - 1):add(fib(n - 2))
    local res = fib(n - 1) + fib(n - 2)
    CACHE[n] = res
    return res
end

function problem2(max)
    local n = 1
    local f = fib(n) 
    local sum = 0
    while f < max do 
        n = n + 1
        f = fib(n)
        if f % 2 == 0 then
            sum = sum + f
        end
    end
    print(sum)
end

problem2(4000000)
