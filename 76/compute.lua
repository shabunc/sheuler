#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
memoize = require("memoize")

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

function R(n, k)
    if k == 0 then
        return 1
    end
    if k > n then
        return R(n, n)
    end
    local res = 0
    for j = 1, k do
        res = res + R(n - j, j)
    end
    return res
end
R = memoize(R)

function P(n)
    return R(n, n)
end

print(P(100))
