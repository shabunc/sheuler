#!/usr/bin/env lua 

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

CACHEBI = {}
CACHEBD = {}

function bi(n, k) 
    local res
    if n == 1 then
        res = 10 - k
        return res
    end
    local res = 0
    for j = k, 9 do
        res = res + bi(n - 1, j)
    end
    return res
end

function bd(n, k)
    local res 
    if n == 1 then
        return k + 1
    end
    local res = 0
    for j = 0, k do
        res = res + bd(n - 1, j)
    end
    return res
end

function f(n)
    local inc = bi(n, 1)
    local dec = bd(n, 9)
    local res = inc + dec - 10
    return res, inc, dec
end

function problem113(n)
    local res = 0
    for j = 1, n do
        res = res + f(j)
    end
    return res
end

assert(problem113(6) == 12951)
assert(problem113(10) == 277032)

print(problem113(11))
