#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(n, rem, len)
    return coroutine.wrap(function() 
        for m = 1, 9 do
            local pr = n * m + rem
            local r = pr % 10
            if r == n then
                coroutine.yield(m, math.floor(pr / 10))
            end
        end
    end)
end

local it  = step(1, 0)
while true do
    local seq, rem = it()
    if not seq then
        break
    end
    print(seq, rem)
end
