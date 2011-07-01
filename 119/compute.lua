#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function ispowerof(n, d)
    if d == 1 then
        return false
    end
    local m = n
    while m ~= 1 do
        if m % d == 0 then
            m = m / d
        else
            return false
        end
    end
    return true
end

function digsum(n)
    return array.reduce(numeric.digits(n), function(a, b) return a + b end)
end

function isgood(n)
    return ispowerof(n, digsum(n))
end


function problem119(n)
    local count = 1
    local m = 10
    while count < n do
        if isgood(m) then
           print(count, m, digsum(m))
           count = count + 1 
        end
        m = m + 1
    end
end

function findsomegen(n)
    local N = bignum(numeric.digits(n))
    local M = N
    while true do
        M = M:mul(N)
        if #M > n then
            return false
        end
        local sum = M:reduce(function(a, b) return a + b end)
        if sum == n then
            coroutine.yield(M)
        end
    end
end

function findsome(n) 
    return coroutine.wrap(function() 
        return findsomegen(n)
    end)
end

function dizzy_search(max)
    local res = {}
    for j = 2, math.huge do 
        local test_it = findsome(j)
        while true do
            local test = test_it()
            if not test then
                break
            end
            if test then
                table.insert(res, test)
                --print(#res, j, test)
            end
        end
        if #res > max then
            break
        end
    end
    table.sort(res, function(a, b) return bignum.compare(a, b) == -1  end)
    for _, v in ipairs(res) do
        print(_, v)
    end
    return res[30]
end

--[[
for j = 1, 90 do
    print(j, dizzy_search(j))
end
]]
dizzy_search(50)
