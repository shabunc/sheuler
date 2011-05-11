#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

local CACHE = {}

function fib(n)
    if n == 1 then
        return bignum{1}
    end
    if n == 2 then
        return bignum{1}
    end
    if CACHE[n] then
        return CACHE[n]
    end
    local res = fib(n - 1):add(fib(n - 2))
    CACHE[n] = res
    return res
end

function problem25(len)
    local n = 1
    local f = fib(n) 
    while #f < len do 
        n = n + 1
        f = fib(n)
        print(n, f)
    end
    print(n, f)
end

problem25(1000)
