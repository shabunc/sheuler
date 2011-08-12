#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function simple_iterator(t)
    local function gen(t, res)
        if #t == 0 then
            coroutine.yield(res)
            return
        end
        for j = 1, #t do
            local lt = array(t)
            local head = table.remove(lt, j)
            local lres = array(res)
            table.insert(lres, head)
            gen(lt, lres)
        end
    end
    return coroutine.wrap(function()
        return gen(t, {})
    end)
end

local it = simple_iterator({1,1,1,2})
while true do
    local seq = it()
    if not seq then
        break
    end
    print(seq)
end 
