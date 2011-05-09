#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("iterator")

function magic_generator(seq, alphabet)
    local rems = array(alphabet)
    for _, v in ipairs(seq) do
        local found = array.index_of(rems, v)
        if found then
            table.remove(rems, found)
        end
    end
    local it = iterator.perm_lex(rems)
    while true do
        local p = it()
        if not p then
            break
        end
        local found = true
        local sum = seq[#seq] + seq[1] + p[#p]
        local res = {{p[#seq], seq[1], seq[#seq]}}
        for j = 1, #seq - 1 do
            if seq[j] + seq[j+1] + p[j] ~= sum then
                found = false
                break
            end
            table.insert(res, {p[j], seq[j + 1], seq[j]})
        end
        if found then
            table.sort(res, function(a, b) return a[1] < b[1] end)
            local flatten = ""
            for _, v in ipairs(res)  do
                flatten = flatten..table.concat(v)
            end
            coroutine.yield(flatten)
        end
    end
end

function magic_iterator(seq, alphabet) 
    return coroutine.wrap(function() 
        return magic_generator(seq, alphabet)
    end)
end

function magic(seq, alphabet)
    local rems = array(alphabet)
    for _, n in ipairs(seq) do
        table.remove(rems, array.index_of(rems, n))
    end
    local it = iterator.perm_lex(rems)
    local first = rems[1]
    while true do
        local nodes = it()
        if nodes[1] ~= first then
            break
        end
        local found = true
        local res = {{nodes[1], seq[1], seq[2]}}
        local sum = array.reduce(res[1], function(a,b) return a + b end)
        for j = 2, #seq  do
            if seq[j] + (seq[j + 1] or seq[1]) + nodes[j] ~= sum then
                found = false
                break
            end
            table.insert(res,{nodes[j], seq[j], seq[j+1]})
        end
        if found then
            local flatten = ""
            for i, v in ipairs(res) do
                flatten = flatten .. table.concat(v)
            end
            print(flatten)
        end
    end
end

function problem68(k, len)
    local total = 0
    local alphabet = {}
    for j = 1, 2*k do
        table.insert(alphabet, j)
    end
    local it = iterator.permutations.combinations(k, alphabet)
    local max = -1
    while true do
        local seq = it()
        if not seq then
            break
        end
        magic(seq, alphabet) 
    end
    --[[
    while true do
        local seq, qes = it()
        if not seq then
            break
        end
        local mit = magic_iterator(seq, alphabet)
        while true do
            local res = mit()
            if not res then
                break
            end
            if string.len(res) == len then
                local digs = {}
                for d in string.gmatch(res, ".") do
                    table.insert(digs, d) 
                end
                local n = numeric.number(digs)
                print(string.format("%i", n), res)
                if n > max then
                    max = n
                end
                total = total + 1
            end
        end
    end
    ]]
    print(string.format("MAX %i", max))
    print("TOTAL", total)
end

problem68(3, 9)
--problem68(5, 16, {1,2,3,4,5,6})
