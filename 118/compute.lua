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
        --print(s)
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
        if seq[#seq] % 2 ~= 0 and seq[#seq] ~= 5 then
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
                    local num = numeric.digits2num(member)
                    if num == 1 then
                        found = false
                        break
                    end
                    if num < prev_num then
                        found = false
                        break
                    else
                        prev_num = num
                    end
                    if not numeric.is_prime(num) then
                        found = false
                        break
                    end
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

prime_set(9)
--[[
local hiterator = numeric.hcombinations_iterator(2,{1,2,3,4,5})
while true do
    local seq, rest = hiterator()
    if not seq then
        break
    end
    print(table.concat(seq), table.concat(rest))
end
]]

--[[
local miterator = numeric.mcombinations_iterator({1},{2,3,4})
while true do
    local seq = miterator()
    if not seq then
        break
    end
    print(#seq, table.concat(seq))
end
]]
--[[
prime_set(9)
local total = 0
for j = 2, 100 do 
    if numeric.is_prime(j) then
        print(j)
        total = total + 1
    end
end
print(total)
]]
