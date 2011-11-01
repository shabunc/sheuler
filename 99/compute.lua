#!/usr/bin/env lua

package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function compare(n, m)
    local a = n[2] * (math.log(n[1]) / math.log(m[1]))
    local b = m[2]
    return a > b
end

dofile("base_exp.txt")

function problem99(t)
    local max = t[1]
    local found = -1
    for j = 2, #t do
        if compare(t[j], max) then
            max = t[j]
            found = j
        end
    end
    return found, max[1], max[2]
end

assert(compare({2, 11},{3, 7}) == false)
assert(compare({632382, 518061},{518061, 518061}) == true)

print(problem99(NUMS))
