#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

VALS = {
    [99] = {1122222222, 11335578},
    [99 * 2] = {1122222222, 5667789},
    [99 * 3] = {1122222222, 3778526},
    [99 * 4] = {2122222212, 5359147},
    [99 * 5] = {11222222220, 22671156},
    [99 * 6] = {11222222220, 18892630},
    [99 * 7] = {1222212222, 1763654},
    [99 * 8] = {2222222112, 2805836},
    [99 * 10] = {11222222220, 11335578}
}

function reduce(a, b)
    local h = numeric.HCF(a, b)
    return a/h, b/h
end


local CACHE = {}

function f(n) 
    if CACHE[n] then
        return CACHE[n]
    end
    for j = 1, math.huge do 
        local m = j * n
        local digs = numeric.digits(m)
        if array.every(digs, function(d) return d <3 end) then
            for _, d in ipairs(numeric.propers(j)) do
                CACHE[n * d] = j
            end
            print(n, j, CACHE[n], j == CACHE[n])
            return j
        end
    end
end

function ff(n, ffunc)
    local sum = 0
    for j = 1, n do
        local res = ffunc(j)
        sum = sum + res
    end
    print("TOTAL", sum)
    return sum
end

function diadic(n)
    local m = bignum({1}, 3)
    local one = bignum({1}, 3)
    local res = {1}
    local checkfrom = n
    while checkfrom > 1 do
        m = m:add(one)
        local dm = numeric.number(m, 10)
        local divs = numeric.propers(dm)
        for _, d in ipairs(divs) do
            if not res[d] then
                res[d] = dm / d
            end
        end
        while res[checkfrom] do 
            print("checkfrom ", checkfrom)
            checkfrom = checkfrom - 1
        end
    end
    return setmetatable(res, {
        __call = function(self, k)
            return self[k]
        end
    })
end

function problem302(n)
    print("finding all diadic values")
    local fd  = diadic(n)
    print("done")
    local res = ff(n, fd)
    print(string.format("TOTAL ", res))
    return res
end

problem302(1000)
