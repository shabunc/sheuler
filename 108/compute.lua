#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function search(n)
    local count = 0
    for j = 1, math.huge do
        local b = j * n
        for d = 1, math.sqrt(b) do
            if b % d == 0 then
                local a = d
                local b = b / d
                if a + b == j then
                    count = count + 1
                    print(a, b, j, count)
                end
            end
        end
    end
end

search(4)
