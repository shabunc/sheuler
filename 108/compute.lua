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
    for a = 2, math.huge do
        local divs = numeric.propers(a)
        for d = 2, #divs do
            local n = (a / divs[d]) * (divs[d] - 1)
            if not res[n] then
                res[n] = 0
            end
            res[n] = res[n] + 1
            if res[n] > lmax then
                lmax = res[n]
                print(lmax)
            end
            if res[n] > max then
                print(string.format("MAX=%i N=%i", res[n], n))
                return
            end
        end
    end
end

problem108(1000)
