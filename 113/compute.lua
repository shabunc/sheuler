#!/usr/bin/env lua 

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function memoize(func)
    local CACHE = {}
    return function(n)
        if CACHE[n] then
            print("CACHE", n)
            return CACHE[n]
        end
        local res = func(n)
        CACHE[n] = res
        return res
    end 
end

function memoize2(func)
    local CACHE = {}
    return function(n, m)
        if CACHE[n] and CACHE[n][m] then
            print("from cache", n, m, CACHE[n][m])
            return CACHE[n][m]
        end
        local res = func(n, m)
        CACHE[n] = {[m] = res}
        return res
    end
end

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

function f2(n)
    local inc = bd(n, 8)
    local dec = bd(n, 9)
    local res = inc + dec - 10
    return res, inc, dec
end


function problem113(n)
    local res = 0
    for j = n, 1, -1 do
        res = res + f2(j)
    end
    return res
end

assert(problem113(6) == 12951)
assert(problem113(10) == 277032)

f = memoize(f)
--bi = memoize2(bi)
--bd = memoize2(bd)

local now = os.clock()
print(problem113(21))
print(string.format("time: %.2f\n", os.clock() - now))
