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
            --print(seq, card)
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end


brute(5)
