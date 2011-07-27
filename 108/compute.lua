#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function fraction(a, b)
    local h = numeric.HCF(a, b)
    return a / h, b / h
end

function add(a, b, c, d)
    return fraction(a * d  + b * c, b * d)
end

function problem108(max)
    local res = {}
    local lmax = -1
    for x = 2, math.huge do
        for y = x, 1, -1 do
            local _, n = add(1, x, 1, y)            
            if _ == 1 then
                if not res[n] then
                    res[n] = 0
                end
                res[n] = res[n] + 1
                if res[n] > lmax then
                    lmax = res[n]
                    print(lmax)
                end
                if res[n] > max then
                    print("MAX n ", res[n], n)
                    return
                end
            end
        end
    end
end

problem108(1000)
