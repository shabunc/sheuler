#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("iterator")

function is_magic(t)
    local sum = array.reduce(t, function(a,b) return a + b end)
    sum = 2 * sum
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
