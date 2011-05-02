#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

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

function good_seq(seq) 
    if #seq <= 2 then
        return true
    end
    for j = 2, #seq do
        if seq[j] < seq[j-1] then
            return false
        end
    end
    return true
end

function problem76(n)
    local total = 0
    for j = 2, n - 1 do
        local it = numeric.sum_iterator(n, j)
        while true do
            local seq = it()
            if not seq then
                break
            end
            if good_seq(seq) then
                print(table.concat(seq," "))
                total = total + 1
            end
        end
    end
    print("TOTAL", total)
    return total
end

problem76(100)
