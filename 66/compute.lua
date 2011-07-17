#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function find(x)
    return coroutine.wrap(function()
        local n = (x - 1) * (x + 1)
        local divs = numeric.propers(n)
        for j = 2, math.sqrt(n) do
            if n % j == 0 then
                if n / j ~= j then
                    if numeric.is_square(n / j) then
                        coroutine.yield(j, n / j)
                    else
                        coroutine.yield(n / j, n)
                    end
                end
            end
        end
    end)
end

function problem66(maxD)
    for x = 3, math.huge do
        local it = find(x) 
        while true do
            local D, y = it()
            if not D then
                break
            end
            if D <= maxD then
                print(x, D, y)
            end
        end
    end
end

problem66(1000)
