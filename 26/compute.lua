#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function digits(n, prec)
    local digs = array{}
    for j = 1, prec do
        table.insert(digs, math.floor(10^j / n) % 10)
    end
    return digs
end


function has_period(f, len)
    for j = 1, len do
        if f[j] ~= f[len + j] then
            return false
        end
    end
    return true
end

function problem26(max)
    local t = 2
    for n = 2, (max - 1) do
        local digs = digits(n, 19)
        print(n, digs, string.format("%.20f", 1/n))
        print("=====")
    end
end

problem26(20)

