#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("array")

function biterator(n)
    local function gen(n, t)
        if n == 0 then
            coroutine.yield(t)
            return
        end
        for j = 0, 1 do
            local lt = array(t) 
            table.insert(lt, j)
            gen(n - 1, lt)
        end
    end
    return coroutine.wrap(function() 
        return gen(n, {})
    end)
end

local bit = biterator(12)
while true do
    local seq = bit()
    if not seq then
        break
    end
    print(seq)
end
