#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function count_combinations(t)
    local a = 0
    local b = 1 
    for i, v in ipairs(t) do
        a = a + v[1]
        b = b * numeric.factorial(v[1])
    end
    return numeric.factorial(a) / b
end

function problem_for(n, ws)
    local it  = numeric.partitions_iterator(n, ws)
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

function problem116(n)
    local res = {}
    table.insert(res, problem_for(n, {4,1}) - 1)
    table.insert(res, problem_for(n, {3,1}) - 1)
    table.insert(res, problem_for(n, {2,1}) - 1)
    return res
end

local res = problem116(50)
print(array.reduce(res, function(a,b) return a + b end))
