#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function maxfunc(init)
    local max =  9 - (init[1] or 0) - (init[2] or 0)
    return max
end

function generate(n, init)
    local inner = #init > 0
    if n == 0 then
        coroutine.yield(init)
    else
        local max = maxfunc(init)
        for head = 0, max do
            local deepinit = array(init)
            table.insert(deepinit, 1, head)
            local recs = generate(n - 1, deepinit)
        end
    end
end

function iterate(n) 
    return coroutine.wrap(function() 
        return generate(n, {})
    end)
end

function problem164(n)
    local total = 0 
    local it = iterate(n)
    while true do
        local seq = it()
        if not seq then
            break
        end
        if seq[1] ~= 0 then
            total = total + 1
            print(table.concat(seq))
        end
    end
    print(string.format("TOTAL %i", total))
    return total
end


problem164(20)
