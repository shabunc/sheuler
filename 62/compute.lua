#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("permutations")

function is_cube(n)
    return math.ceil(n^(1/3))^3 == n
end


function find_some(n, func)
    local digs = numeric.digits(n)
    --TODO выяснить, нужен ли этот шаг действительно
    local it = perm.lexicographic_iterator(digs)
    local res = {}
    while true do
        local seq = it()
        --print(seq)
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
    return res
end

local CACHE = {}

function problem62(max)
    local n = 100 
    local excluded = {}
    while true do
        local cube = n^3
        local digs = numeric.digits(cube)
        table.sort(digs)
        local key = table.concat(digs,"")
        print(n, cube)
        if CACHE[key] then
            table.insert(CACHE[key], cube)
            if #CACHE[key] == max then
                print(table.concat(CACHE[key]," "))
                return n
                --[[
                local found = find_some(tonumber(key), is_cube)
                print(table.concat(found," "))
                return found, n
                ]]
            end
        else
            CACHE[key] = {cube}
        end
        n = n + 1
    end
end

--assert(table.concat(find_some(41063625, is_cube)," ") == "41063625 56623104 66430125")

--print(table.concat(find_some(1432197595648, is_cube)))
problem62(5)
