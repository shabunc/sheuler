#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("permutations")

function is_cube(n)
    for j = math.floor(math.sqrt(n)), 1, -1 do
        if j*j*j == n then
            return true
        end
    end
    return false
end

function find_some(n, func)
    local digs = numeric.digits(n)
    local it = perm.iterator(digs)
    local res = {}
    while true do
        local seq = it()
        if not seq then
            break
        end
        local nseq = numeric.number(seq)
        if func(nseq) then
            table.insert(res, nseq)
        end
    end
    print(table.concat(res," "))
    return res
end

find_some(41063625, is_cube)
