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
            for j = 1, p[2] do
                coroutine.yield(array.sub(a, 1, p[1]))
                a = array.sub(a, p[1] + 1)
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
        local parts = numeric.partitions_iterator(n, {9,8,7,6,5,4,3,2,1})
        while true do 
            local part = parts()
            local found = true
            if not part then
                break
            end
            local set = part_string_iterator(seq, part)
            local ss = {}
            while true do
                local member = set()
                if not member then
                    break
                end
                local num = numeric.digits2num(member)
                if not numeric.is_prime(num) then
                    found = false
                    break
                end
                if #member > 0 then
                    table.insert(ss, num)
                end
            end
            if found then
                local is_asc = true
                for j = 2, #ss do
                    if ss[j] < ss[j-1] then
                        is_asc = false
                        break
                    end
                end
                if is_asc  then
                    print(table.concat(seq), part, table.concat(ss,":"), is_asc)
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
