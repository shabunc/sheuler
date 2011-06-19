#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("iterator")

function points(n)
    local res = {}
    for j = 0, n do
        for i = 0, n do
            if not ((j == 0) and (i == 0)) then
                table.insert(res,{j, i})
            end
        end
    end
    return res
end

function are_orthos(ta, tb) 
    local prod = array.zipWith(function(a, b) return a*b end, ta, tb)
    local res = array.every(prod, function(a) return a == 0 end)
    return res
end

function are_pythas(ta, tb)
    local td = array.zipWith(function(a, b) return (a - b) end, ta, tb)
    local it = iterator.combinations(2, {ta, tb, td})
    while true do
        local seq = it()
        if not seq then
            break
        end
        if are_orthos(seq[1], seq[2]) then
            return true
        end
    end
    return false
end

function problem91(n)
    local res = {}
    local it = iterator.combinations(2, points(n))
    local total = 0
    while true do
        local seq = it()
        if not seq then
            break
        end
        if are_pythas(seq[1],seq[2]) then
            total = total + 1
        end
    end
    print(string.format("TOTAL %i => %i", n, total))
    return total
end

assert(problem91(2) == 12)
problem91(12)
