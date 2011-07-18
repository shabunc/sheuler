#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function find(x)
    return coroutine.wrap(function()
        local n = (x - 1) * (x + 1)
        local divs = numeric.propers(n)
        table.sort(divs)
        for j = 2, math.sqrt(n) do
            if n % j == 0 then
                if n / j ~= j then
                    if numeric.is_square(n / j) then
                        coroutine.yield(j, n / j)
                    elseif numeric.is_square(j) then
                        coroutine.yield(n / j, n)
                    end
                end
            end
        end
    end)
end

function findquick(x)
    return coroutine.wrap(function()
        local n = (x - 1) * (x + 1)
        for y = 1, math.sqrt(n) do
            if n % (y * y)  == 0 then
                coroutine.yield(n / (y * y), y)
            end
        end
    end)
end

function problem66(maxD)
    local mins = {}
    local total = maxD - math.floor(math.sqrt(maxD))
    local count = 0
    for x = 2, math.huge do
        local it = findquick(x)
        while true do
            local D, y = it()
            if not y then
                break
            end
            if D <= maxD then
                if not mins[D] then
                    mins[D] = x
                    count = count + 1
                    print(string.format("%i\t%i\t%i", x, D, y), count, total, string.format("%0.2f", count/total))
                end
                if count == total then
                    return x
                end
            end
        end
    end
end

problem66(1000)
