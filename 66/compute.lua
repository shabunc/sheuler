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

function problem66(maxD)
    local mins = {}
    for x = 2, math.huge  do
        print(x)
        local it = find(x) 
        while true do
            local D, y = it()
            if not D then
                break
            end
            if D == maxD then
                return x 
                --[[
                if not mins[D] then
                    mins[D] = x
                    print(x, D, y)
                    break
                end
                ]]
            end
        end
    end
end

print(problem66(61))
--[[
local res = {}
for j = 2, 1000 do
    if not numeric.is_square(j) then
        table.insert(res, problem66(j))
        print(j, res[#res])
    end
end
table.sort(res)
print(table.concat(res, " "))
]]
