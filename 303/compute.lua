#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function f(n) 
    for j = 1, math.huge do 
        local m = j * n
        local digs = numeric.digits(m)
        if array.every(digs, function(d) return d <3 end) then
            return m, j
        end
    end
end

function test(m)
    local digs = numeric.digits(m)
    return array.every(digs, function(d) return d < 3 end) and m
end

function fim(n)
    -- filter (\a -> n * a `mod` 10 < 3) [0..9]
    local checks = {
        [0] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
        [1] = {0, 1, 2},
        [2] = {0, 1, 5, 6},
        [3] = {0, 4, 7},
        [4] = {0, 3, 5, 8},
        [5] = {0, 2, 4, 6, 8},
        [6] = {0, 2, 5, 7},
        [7] = {0, 3, 6},
        [8] = {0, 4, 5, 9},
        [9] = {0, 8, 9},
    }
    local checkvals = checks[n % 10]
    for j = 0, math.huge, 10 do 
        for _, d in ipairs(checkvals) do
            if not (d == 0 and  j ==0) then
                --print(n, j, d)
                m = test((j + d) * n) 
                if m then
                    return m, (j + d)
                end
            end
        end
    end
end

function fdiad(n) 
    local b = bignum({0},3) 
    while true do
        b = b:add(bignum({1},3))
        local m = numeric.number(b)
        if m % n == 0 then
            return m, m/n
        end
    end
end

function ff(n, func)
    local total = 0
    for j = 1, n do
        local _, k = func(j)
        --print(string.format("%i %i %i", j, k, _))
        total = total + k
    end
    print("TOTAL", total)
    return total
end

for j = 501, 2000 do
    print(j, "=====")
    assert(fim(j) == fdiad(j))
end
--assert(ff(100, fim) == 11363107)
--print("TOTAL", string.format("%i",ff(10000)))
