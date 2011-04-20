#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("permutations")



function part_string_generator(a, parts) 
    for _, p in pairs(parts) do
        if p[1] ~= 0 then
            for j = 1, p[1] do
                coroutine.yield(array.sub(a, 1, p[2]))
                a = array.sub(a, p[2] + 1)
            end
        end
    end
end

function part_string_iterator(s, parts) 
    return coroutine.wrap(function() return part_string_generator(s, parts) end)
end

function prime_set(n)
    local lex = perm.lexicographic_iterator({1,2,3,4,5,6,7,8,9})
    local total = 0
    while true do
        local seq = lex()
        if not seq then
            break
        end
        if seq[#seq] % 2 ~= 0  then
            local parts = numeric.partitions_iterator(n, {9,8,7,6,5,4,3,2,1})
            while true do 
                local part = parts()
                local found = true
                if not part then
                    break
                end
                local set = part_string_iterator(seq, part)
                local ss = {}
                local prev_num = -1
                while true do
                    local member = set()
                    if not member then
                        break
                    end
                    --[[
                    local num = numeric.digits2num(member)
                    if num < prev_num or num == 1 or #member == 9 then
                        found = false
                        break
                    else
                        prev_num = num
                    end
                    if not numeric.is_prime(num) then
                        found = false
                        break
                    end
                    ]]
                    if #member > 0 then
                        table.insert(ss, num)
                    end
                end
                if found then
                    print(table.concat(seq), part, table.concat(ss,":"))
                    total = total + 1
                end
            end
        end
    end
    print("TOTAL", total)
    return total
end

function search_prime_seq(t, from, inner) 
    if from > #t then
        return {{}}
    end
    local res = {}
    local head = {}
    local prev_match = 0
    for j = from, #t do
       table.insert(head, t[j])
       local num_head = numeric.digits2num(head)
       if ((t[j] == 5 or t[j] == 2) and j == from)  or t[j] == 1 or t[j] == 3 or t[j] == 7 or t[j] == 9 then
           if (numeric.is_prime(num_head)) then 
                local tail = search_prime_seq(t, j + 1, true)
                for k = 1, #tail do
                    table.insert(tail[k], 1, num_head)
                    table.insert(res, tail[k])
                    if not inner then 
                        coroutine.yield(tail[k])
                    end
                end
           end
       end
    end
    if inner then
        return res
    end
end

function prime_seq_iterator(t) 
    return coroutine.wrap(function() return search_prime_seq(t, 1) end)
end

function problem118(n, t)
    local iterator = perm.lexicographic_iterator(t)
    local total = 0
    while true do
        local p = iterator()
        if not p then 
            break
        end
        local it = prime_seq_iterator(p) 
        while true do
            local seq = it()
            if not seq then
                break
            end
            table.sort(seq)
            print(table.concat(seq,":"))
            --[[
            local s = ""
            for i, v in ipairs(seq) do
                s = s .. table.concat(v) .. "=>"
            end
            print(s)
            ]]
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end


--[[
local it = prime_seq_iterator({4,5,6,7,8,9,2,3,1})
while true do
    local seq = it()
    if not seq then
        break
    end
end
]]

--prime_set(9)
problem118(9, {1,2,3,4,5,6,7,8,9})
