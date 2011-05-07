#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("permutations")

function is_cube(n)
    return math.ceil(n^(1/3))^3 == n
end

local CACHE = {}


function find_some(n, func)
    local digs = numeric.digits(n)
    local it = perm.iterator(digs)
    local res = {}
    while true do
        local seq = it()
        if not seq then
            break
        end
        if seq[1] ~= 0 then
            local nseq = numeric.number(seq)
            if func(nseq) then
                table.insert(res, nseq)
            end
        end
    end
    table.sort(res)
    local uniq = {res[1]}
    for j = 2, #res do 
        if res[j] ~= uniq[#uniq] then
            table.insert(uniq, res[j])
        end
    end
    return uniq
end

function problem62(max)
    local n = 100 
    local excluded = {}
    while true do
        local cube = n^3
        print(n, cube)
        local found = find_some(cube, is_cube)
        if #found == max then
            print(table.concat(found, " "))
            return found, n
        end
        n = n + 1
    end
end

assert(table.concat(find_some(41063625, is_cube)," ") == "41063625 56623104 66430125")

problem62(5)
