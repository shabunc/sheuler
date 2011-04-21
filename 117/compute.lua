#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function tile_generator(n, m, inner)
    if n == 0 then
        return {{}}
    end
    local res = {}
    for head = 1, m  do
        if head > n then
            break
        end
        local tail = tile_generator(n - head, m, true)
        for i, seq in ipairs(tail) do
            table.insert(seq, 1, head)
            table.insert(res, seq)
            if not inner then
                coroutine.yield(seq)
            end
        end
    end
    if inner then
        return res
    end
end

function tile_iterator(n, m)
    return coroutine.wrap(function() return tile_generator(n, m) end)
end

function problem117brute(n, m)
    local it = tile_iterator(n, m)
    total = 0
    while true do
        local seq = it()
        if not seq then
            break
        end
        print(table.concat(seq," "))
        total = total + 1
    end
    print("TOTAL", total)
    return total
end

function count_combinations(t)
    local a = 0
    local b = 1 
    for i, v in ipairs(t) do
        a = a + v[1]
        b = b * numeric.factorial(v[1])
    end
    return numeric.factorial(a) / b
end

function problem117(n)
    local it  = numeric.partitions_iterator(n, {4,3,2,1})
    total = 0
    while true do
        local seq = it()
        if not seq then
            break
        end
        print(seq,  count_combinations(seq))
        total = total + count_combinations(seq)
    end
    print("TOTAL", string.format("%i", total))
    return total
end

problem117(50, 4)
