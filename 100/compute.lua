#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
require("numeric")

function problem100(max)
    local vals  = {}
    for j = 1, math.huge do
        local val = j * (j - 1)
        vals[val] = j
        if vals[val / 2] then
            print(j, vals[val / 2])
            if j > max then
                break
            end
        end
    end
end

for j = 1, 10 ^ 12 do
    print(j)
end
