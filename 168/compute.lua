#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(len)
    local function step_generator(n, rem, len)
        for m = 1, 9 do
            local pr = n * m + rem
            local r = pr % 10
            if r == n then
                coroutine.yield(m, math.floor(pr / 10))
            end
        end
    end
    return coroutine.wrap(function() 
        for n = 1, 9 do
            step_generator(n, 0, len)
        end
    end)
end

local it  = step(3)
while true do
    local seq, rem = it()
    if not seq then
        break
    end
    print(seq, rem)
end
