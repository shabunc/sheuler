#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function is_square(a)
    return a % math.sqrt(a) == 0
end

function findall(a)
    for j = -1, 1, 2 do
        local b = 2*a - j
        local h = b^2 - a^2 
        if is_square(h) then
            print(2*a, b, 2*a + 2*b)
        end
    end
end

function problem94(n) 
    local max = (n + 1)/6
    for a = 1, max do
        findall(a)
    end
end

problem94(10^9)
