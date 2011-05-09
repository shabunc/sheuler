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
        local res = {{p[#seq], seq[#seq], seq[1]}}
        for j = 1, #seq - 1 do
            if seq[j] + seq[j+1] + p[j] ~= sum then
                found = false
                break
            end
            table.insert(res, {p[j], seq[j], seq[j+1]})
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

function problem68()
    local total = 0
    local alphabet = {1,2,3,4,5,6,7,8,9,10}
    local it = iterator.permutations.combinations(5, alphabet)
    local max = -1
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
            if string.len(res) == 16 then
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
    print(string.format("MAX %i", max))
    print("TOTAL", total)
end

problem68()
