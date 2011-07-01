#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function generate(n, inner)
    if n == 0 then
        return {{}}
    end
    local res = {}
    for head = 0, 9 do
        local recs = generate(n - 1, true)
        for _, rec in ipairs(recs) do
            table.insert(rec, 1,  head)
            table.insert(res, rec)
            if not inner then
                coroutine.yield(rec)  
            end
        end
    end
    if inner then
        return res
    end
end

function iterate(n) 
    return coroutine.wrap(function() 
        return generate(n, false)
    end)
end

function problem164(n)
    local it = iterate(n)
    while true do
        local seq = it()
        if not seq then
            break
        end
        print(table.concat(seq))
    end
end


problem164(6)
