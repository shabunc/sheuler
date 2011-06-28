#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function is_square(a)
    return a % math.sqrt(a) == 0
end

function findall(a)
    for j = 1, 2*a + 1 do
        local b2 = a^2 + j^2
        local b = math.sqrt(b2)
        if math.abs(2*a - b) == 1 then
            print(2*a, b, 2 * (a + b))
        end
    end
end

for j = 1, 20000 do
    findall(j)
end
