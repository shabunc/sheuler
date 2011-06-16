#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function f(n) 
    if n % 99 == 0 then
        return 1122222222, 1122222222 / n
    end
    if n % 813 == 0 then
        return 1111122222, 1111122222 / n
    end
    if n % 909 == 0 then
        return 10122222222, 10122222222 / n
    end
    if n % 989 == 0 then
        return 11212202012, 11212202012 / n
    end
    for j = 1, math.huge do 
        local m = j * n
        local digs = numeric.digits(m)
        if array.every(digs, function(d) return d <3 end) then
            print(m, j)
            return m, j
        end
    end
end

function ff(n)
    local total = 0
    for j = 1, n do
        print(j)
        local _, k = f(j)
        total = total + k
    end
    return total
end

print(f(999))

--[[
assert(ff(100) == 11363107)
print("TOTAL", ff(10000))
]]
