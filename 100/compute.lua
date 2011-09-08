#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
require("numeric")

function root(n)
    return math.sqrt(n + 0.25) + 0.5
end

function problem100(max)
    --for j = from, math.huge do
    for j = 1, math.huge do
        local val = j * (j - 1)
        local b = root(val / 2)  
        if b == math.floor(b) then
            print(j, b)
            if j > max then
                break
            end
        end
    end
end

problem100(1e2)
