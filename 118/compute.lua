#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("permutations")

function is_prime(n)
    for j = 3, math.sqrt(n), 2 do
    end
end

function problem118(n, t)
    local iterator = numeric.partitions_iterator(n, t, 1)
    local total = 0
    while true do
        local p = iterator()
        if not p then 
            break
        end
        local s = ""
        total = total + 1
        for i, v in ipairs(p) do
            s = s.." "..v[1].."*"..v[2] 
        end
        print(s)
    end
    print(total)
    return total
end

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
    for j = from, #t do
       table.insert(head, t[j])
       if (j == 1 and t[1] == 5)  or t[j] == 1 or t[j] == 3 or t[j] == 7 or t[j] == 9 then
            local tail = search_prime_seq(t, j + 1, true)
            for k = 1, #tail do
                table.insert(tail[k], 1, array.copy(head))
                table.insert(res, tail[k])
                if not inner then 
                    coroutine.yield(tail[k])
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


local it = prime_seq_iterator({9,2,3,4,6,7,8,1, 5})
while true do
    local seq = it()
    if not seq then
        break
    end
    local s = ""
    for i, v in ipairs(seq) do
        s = s .. table.concat(v) .. "=>"
    end
    print(s)
end

--prime_set(9)
