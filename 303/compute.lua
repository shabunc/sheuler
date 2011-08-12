#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")


function reduce(a, b)
    local h = numeric.HCF(a, b)
    return a/h, b/h
end


function f(n) 
    for j = 1, math.huge do 
        local m = j * n
        local digs = numeric.digits(m)
        if array.every(digs, function(d) return d <3 end) then
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

local n = 7
for j = 1, 10 do
    for i = 1, 10 do
        local a = f(i)
        local b = f(j)
        local c = f(i * j)
        print(i, j, a, b, c, a * b)
    end
end
