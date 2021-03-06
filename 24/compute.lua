#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("permutations")

function dumb()
    local a, b = 0, 9
    local NTH = 1000000
    local counter = 0
    for a0 = a, b do 
        for a1 = a, b do 
            if a1 ~= a0 then
            for a2 = a, b do 
                if a2 ~= a1 and a2 ~= a0 then
                for a3 = a, b do
                    if a3 ~= a2 and a3 ~= a1 and a3 ~= a0 then
                    for a4 = a, b do 
                        if a4 ~= a3 and a4 ~= a2 and a4 ~= a1 and a4 ~= a0 then
                        for a5 = a, b do
                            if a5 ~= a4 and a5 ~= a3 and a5 ~= a2 and a5 ~= a1 and a5 ~= a0 then
                            for a6 = a, b do
                                if a6 ~= a5 and a6 ~= a4 and a6 ~= a3 and a6 ~= a2 and a6 ~= a1 and a6 ~= a0 then
                                for a7 = a, b do 
                                    if a7 ~= a6 and a7 ~= a5 and a7 ~= a4 and a7 ~= a3 and a7 ~= a2 and a7 ~= a1 and a7~= a0 then
                                    for a8 = a, b do
                                        if a8 ~= a7 and a8 ~= a6 and a8 ~= a5 and a8 ~= a4 and a8 ~= a3 and a8 ~= a2 and a8 ~= a1 and a8 ~= a0 then
                                        for a9 = a, b do 
                                            if a9 ~= a8 and a9 ~= a7 and a9 ~= a6 and a9 ~= a5 and a9 ~= a4 and a9 ~= a3 and a9 ~= a2 and a9 ~= a1 and a9 ~= a0 then
                                                counter = counter + 1
                                                if counter == NTH then
                                                    print(table.concat({a0,a1,a2,a3,a4,a5,a6,a7,a8,a9})) 
                                                    return 
                                                end
                                            end
                                        end
                                        end
                                    end
                                    end
                                end 
                                end
                            end
                            end
                        end
                        end
                    end
                    end
                end
                end
            end
            end
        end
    end
end

function copy(t) 
    local res = {}
    for j in ipairs(t) do
        res[j] = t[j]
    end
    return res
end

function recursive(t)
    local all = {}
    if #t == 1 then
        return {t}
    end 
    for j in ipairs(t) do
        local tail = copy(t)
        local head = table.remove(tail, j)
        local perms = recursive(tail)
        for i in ipairs(perms) do
            table.insert(perms[i], 1, head)
            table.insert(all, perms[i])
        end
    end
    return all
end

function recursive2(t, from)
    local all = {}
    if from == #t then
        coroutine.yield(t)
    end 
    for j = from, #t do
        local head = table.remove(t, j)
        table.insert(t, 1, head)
        local perms = recursive2(t, from + 1)
        table.insert(t, j, table.remove(t, 1))
    end
    return {}
end

function factoradic(n)
    local facts = {1}
    while true do
        local next_fact = facts[#facts] * (#facts + 1)
        if next_fact > n  then
            break
        end
        facts[#facts + 1] = next_fact
    end
    local res = {}
    for j=#facts, 1, -1 do
       local remainder = n % facts[j]
       res[#res + 1] = (n - remainder) / facts[j]
       n = remainder
    end
    res[#res + 1] = 0
    return res
end

function lehrner(num_factoradic, t) 
    local res = {}
    local current_table = copy(t)
    for j = 1, #num_factoradic do
        res[#res + 1] = table.remove(current_table,num_factoradic[j] + 1)
    end
    return res
end

function problem24(t)
    local iterator = perm.lexicographic_iterator(t)
    while true do
        local permutation = iterator()
        if not permutation then break end
        print(table.concat(permutation))
    end
end

problem24({1,2,3,4})
