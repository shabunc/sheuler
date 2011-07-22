#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(a, b, c)
    return coroutine.wrap(function() 
        for j = -1, 1, 2 do
            for i = -1, 1, 2 do
                local a = a * j
                local b = b *  i
                local na = a + 2 * b + 2 *c
                local nb = 2 * a + b + 2 * c
                local nc = 2 * a + 2 * b + 3 * c
                if na > 0 and nb > 0 and nc > 0 then
                    coroutine.yield(na, nb, nc)
                end
            end
        end
    end)
end

local it = step(5, 12, 13)
while true do 
    local  a, b, c = it()
    if not a then
        break
    end
    print(a, b, c)
end
