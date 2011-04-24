#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("permutations")

function insert_sorted(t, n)
    if #t == 0 then
        t[1] = n
        return t
    end
    if n < t[1] then
        table.insert(t, 1, n)
    end
    for j = 1, #t do
        if n > t[j] and (j == #t or n < t[j+1]) then
            table.insert(t, j + 1, n)
            break
        end
    end
    return t
end

local FOUND = {}

function is_arithmetic_sequence(num)
    local t = numeric.num2digits(num)
    local all_possible = {}
    local it = perm.iterator(t)
    local diff
    while true do
        local seq = it()
        if not seq then
            break
        end
        local n = numeric.digits2num(seq)
        if seq[1] ~= 0 and numeric.is_prime(n) then
             insert_sorted(all_possible, n)
        end
    end
    if #all_possible > 2 then
        local comb_it  = numeric.combinations_iterator(3, all_possible)
        while true do
            local comb = comb_it()
            if not comb then 
                break
            end
            if comb[2] - comb[1] == comb[3] - comb[2] and comb[1] < comb[3] and not FOUND[comb[1]] then
                print(table.concat(comb,""))
                FOUND[comb[1]] = comb
            end
        end
    end
    return true
end

function problem49(n)
    local num = 10^(n-1) + 1
    local count = 0
    while num < 10^n  do
        num = num + 2
        if count ~= 1 then
            if is_arithmetic_sequence(num) then

            end
        end
        count = (count + 1) % 5
    end
end

problem49(4)
