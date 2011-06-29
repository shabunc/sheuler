#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function is_square(a)
    return a % math.sqrt(a) == 0
end

TOTAL = 0

function findall(p)
    for j = -1, 1, 2 do
        if (p + j) % 3 == 0 then
            local a = (p + j) / 3
            local b = a - j
            local h  = math.sqrt(b^2 - (0.5*a)^2)
            if h > 0 and math.floor(h) == math.ceil(h) then
                print(a, b, h, a + 2*b)
                TOTAL = TOTAL + (a + 2*b)
            end
        end
    end
end

function problem94(n) 
    for p = 2, n do 
        findall(p)
    end
    print("TOTAL", TOTAL)
end

problem94(10^9)
