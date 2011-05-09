#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("iterator")

function is_magic(t)
    local res = {}
    for j = 1, #t - 1 do
        local n = t[j] + t[j+1]
        table.insert(res, n)
    end
    table.insert(res, t[#t] + t[1])
    print(table.concat(t), table.concat(res," "))
    return res
end

function problem68()
    local total = 0
    local it = iterator.permutations.combinations(5, {1,2,3,4,5,6,7,8,9})
    while true do
        local seq = it()
        if not seq then
            break
        end
        is_magic(seq)
        total = total + 1
    end
    print(total)
end

problem68()
