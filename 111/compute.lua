#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function merge_iterator(ta, tb)
    local function gen(ta, tb, n)
       if n == #ta + 1 then
            coroutine.yield(tb)
            return
       end
       for j = 1, #tb + 1 do
            local ltb = array(tb)
            table.insert(ltb, j, ta[n])
            gen(ta, ltb, n + 1)
       end
    end
    return coroutine.wrap(function()
        return gen(ta, tb, 1)
    end)
end

local mit = merge_iterator({1,1,1},{7})
while true do
    local seq = mit()
    if not seq then
        break
    end 
    print("=>", seq)
end
