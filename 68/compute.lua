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
        local res = {seq[#seq], seq[1], p[#p]}
        for j = 1, #seq - 1 do
            if seq[j] + seq[j+1] + p[j] ~= sum then
                found = false
                break
            end
            table.insert(res, {seq[j], seq[j+1], p[j]})
        end
        if found then
            coroutine.yield(res)
        end
    end
end

function magic_iterator(seq, alphabet) 
    return coroutine.wrap(function() 
        return magic_generator(seq, alphabet)
    end)
end

function problem68()
    local total = 0
    local alphabet = {1,2,3,4,5,6,7,8,9,10}
    local it = iterator.permutations.combinations(5, alphabet)
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
            print(res)
            total = total + 1
        end
    end
    print(total)
end

problem68()
