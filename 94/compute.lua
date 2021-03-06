#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function stackstep(maxp)
    return coroutine.wrap(function()
        local stack = {{3, 4, 5}}
        while #stack > 0 do
            local a, b, c = unpack(table.remove(stack))
            if a > 0 and b > 0 and c > 0 and (a +  b + c) < maxp then
                coroutine.yield(a, b, c)
                for _, la in ipairs{-a, a} do
                    for _, lb in ipairs{-b, b} do
                        local na = la + 2 * lb + 2 * c
                        local nb = 2 * la + lb + 2 * c
                        local nc = 2 * la + 2 * lb + 3 * c
                        table.insert(stack, {na, nb, nc})
                    end
                end
            end
        end
    end)
end

function genall(maxp)
    local it = stackstep(maxp)
    local total = 0
    local sum = 0
    while true do
        local a, b, c = it()
        if not a then
            break
        end
        local t = {a, b, c}
        table.sort(t)
        a, b, c = unpack(t)
        local p = 2 * a + b + c
        if p < maxp and math.abs(c - 2 * a) == 1 and  b % 2 == 0 then
            total = total + 1
            sum = sum + p
            print(a, b, c, c - 2 * a, c - 2 * b,  p, b * a / 2)
        end
    end
    print("TOTAL", total)
    print(string.format("RES %i", sum))
end

genall(1000000000)

