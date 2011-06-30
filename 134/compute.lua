#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function smallest(n)
    local p1 = numeric.prime(n)
    local p2 = numeric.prime(n + 1)
    for j = 1, math.huge do
        local m = j * 100 + p1
        if m % p2 == 0 then
            return m
        end
    end
end

smallest(8)
