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

function subseq(seq, bitmask)
    local sub, cosub = {}, {}
    for i, b in ipairs(bitmask) do
        if b == 1 then
            table.insert(sub, seq[i])
        else
            table.insert(cosub, seq[i])
        end
    end
    return sub, cosub
end

function explore(t)
    table.sort(t)
    local bit = biterator(#t)
    while true do
        local bitmask = bit()
        if not bitmask then
            break
        end
        local seq, cosub = subseq(t, bitmask)
        local cobit = biterator(#cosub)
        while true do
            local cobitmask = cobit()
            if not cobitmask then
                break
            end
            local coseq = subseq(cosub, cobitmask)
            print(table.concat(seq, " "), table.concat(coseq, " "))
        end
    end
end

explore({81, 88, 75, 42, 87, 84, 86, 65})
