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
           print(count, m)
           count = count + 1 
        end
        m = m + 1
    end
end

function findsome(n)
    local N = bignum(numeric.digits(n))
    local m = n
    while true do
        m = m * n
        if m > 10^21 then
            return false
        end
        if digsum(m) == n then
            return m
        end
    end
end

function dizzy_search()
    local max = 25
    local res = {}
    for j = 2, math.huge do 
        local test = findsome(j)
        if test then
            table.insert(res, test)
        end
        if #res > max then
            break
        end
    end
    table.sort(res)
    for _, v in ipairs(res) do
        print(_, string.format("%i", v))
    end
end

dizzy_search()

