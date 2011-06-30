#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

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

problem119(30)
