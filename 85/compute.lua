#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function count(n, m)
    local total = 0
    for j = 1, n do
        for i = 1, m do
           total = total + (n - j + 1) * (m - i + 1)
        end
    end
    return total
end

function problem85(max)
    local closest = math.huge
    for n = 2, math.huge do
        for m = n, 1, -1 do
            local val = count(n, m)
            if math.abs(max - val) < closest then
                closest = math.abs(max - val)
                print(n, m, val, n * m)
            end
        end
    end
end

assert(count(3,2) == 18)

problem85(2 * 10^6)
