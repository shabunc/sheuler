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

--assert(ff(100, fim) == 11363107)
--print("TOTAL", string.format("%i",ff(10000)))

function digen(n) 
    if n == 0 then
        return {{}}
    end
    for head = 0, 2 do
        local recs = digen(n - 1)
    end
end

function fimdiad(max) 
    local t = {}  
    local b = bignum({0}, 3)
    local continious = 0
    while true do
        b = b:add(bignum{1}, 3)
        local n = numeric.number(b)
        print(n, continious)
        if continious >= max then
            break
        end
        t[b] = 1
        for m = 1, math.sqrt(n) do
            if n % m == 0 then
                local com = n / m
                if not t[m] or t[m] > com then
                    t[m] = com
                end
                if not t[com] or t[com] > m then
                    t[com] = m
                end
                while true do
                    if t[continious + 1] then
                        continious = continious + 1
                    else
                        break
                    end
                end
            end
        end
    end
    res = array.sub(t, 1, max)
    print("CONTINIOUS LENGTH", #res)
    print(res:reduce(function(a, b) return a + b end))
    return res
end


fimdiad(10000)
