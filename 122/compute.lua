#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function m(k)
    local max = 0
    local num = 0
    for j = k, 2, -1 do
        local divs = numeric.divisors(j)
        if divs[1][1] == 2 and divs[1][2] > max then
            max = divs[1][2]
            num = j
        end
    end
    return max, num
end

for j = 1, 200 do
    print(j, m(j))
end
