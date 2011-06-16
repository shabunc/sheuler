#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

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
    if n % 999 == 0 then
    end
    for j = 10^7, math.huge do 
        local m = j * n
        local digs = numeric.digits(m)
        if array.every(digs, function(d) return d <3 end) then
            return m, j
        end
    end
end

function fdiad(n) 
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
    if n % 999 == 0 then
        return 112222222222222, 112222222222222 / n
    end
    local b = bignum({0},3) 
    while true do
        b = b:add(bignum({1},3))
        local m = numeric.number(b)
        if m % n == 0 then
            return m/n, n
        end
    end
end

function ff(n)
    local total = 0
    for j = 1, n do
        print(j)
        local _, k = fdiad(j)
        total = total + k
    end
    return total
end


print("TOTAL", ff(10000))
