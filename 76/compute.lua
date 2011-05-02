#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("thread")

function brute(n)
    local total = 0
    local parts = {}
    local count = function(a, b) 
        return a + numeric.sign(b[1])
    end
    for j = n, 1, -1 do
        table.insert(parts, j)
    end
    local it = numeric.partitions_iterator(n, parts)
    while true do
        local seq = it()
        if not seq then
            break
        end
        local card = array.reduce(seq, count)
        if card > 1 then
            print(seq, card)
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end

function sum_generator(n, inner)
    if n == 1 then
        return {{1}}
    end
    local res = {}
    for head = n - 1, math.ceil(n/2), -1  do
        --coroutine.yield({head, n - head})
        local tail = sum_generator(n - head, true)
        for i, v in ipairs(tail) do
            table.insert(v, 1, head)
            table.insert(res, v)
            if not inner then
                coroutine.yield(v)
            end
        end
        --[[
        ]]
    end
    if inner  then
        return res
    end 
end

function sum_iterator(n) 
    return thread.wrap(function() return sum_generator(n) end)
end

function problem76(n)
    local it = sum_iterator(n)
    local total = 0
    while true do
        local seq = it()
        if it.dead() then
            break
        end
        print(table.concat(seq))
        total = total + 1
    end
    print("TOTAL", total)
    return total
end

--[[
for j = 10, 10 do
    brute(j)
end
]]