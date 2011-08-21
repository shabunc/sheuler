#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function combit(t, n)
    local function gen(t, n, from, res)
        if n == 0  then
            coroutine.yield(res)
            return
        end
        for j = from, #t do
            local lres = array(res)
            table.insert(lres, t[j])
            gen(t, n - 1, j + 1, lres)
        end
    end
    return coroutine.wrap(function() 
        return gen(t, n, 1, {})
    end)
end

function squares(max)
    local res = {}
    for j = 1, max do
        table.insert(res, j * j)
    end
    return res
end

function search(max)
    local sqs = squares(max)
    local it = combit(sqs, 6) 
    while true do
        local seq = it()
        if not seq then
            break
        end
        local e, f, b, d, c, a = unpack(seq)
        if (a + b) % 2 == 0 then
            if (c + d) % 2 == 0 then
                if (f + e) % 2 == 0 then
                    local x = (a + b) / 2
                    local y = (e + f) / 2
                    print(x, y, x + y)
                end
            end
        end
    end
end

search(10)
