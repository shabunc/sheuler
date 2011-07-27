#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function hexs(len) 
    local function hexs_gen(glen, ts, res) 
        if glen == 0 then
            coroutine.yield(res)
            return
        end
        local from = 1
        if #res == 1  then
            from = 2
        end
        for j = from, #ts do
            local lres = array(res)
            table.insert(lres, ts[j])
            hexs_gen(glen - 1, ts, lres)
        end
    end
    return coroutine.wrap(function() 
        return hexs_gen(len, {0,1,2,3,4,5,6,7,8,9,"A","B","C","D","E","F"}, {})
    end)
end

function brute162(n)
    local it = hexs(n)
    local total = 0
    while true do
        local seq = it()
        if not seq then
            break
        end
        local found_0 = seq:index_of(0) > 0
        local found_1 = seq:index_of(1) > 0
        local found_A = seq:index_of("A") > 0
        if found_0 and found_1 and found_A then
            --print(table.concat(seq))
            total = total + 1
        end
    end
    print(string.format("TOTAL %i %i", n, total))
    return total
end

function problem162(n)
    local total = 0
    for j = 3, n do
        total = total + brute162(j)
    end
    print(string.format("TOTAL %i", total))
    return total
end

problem162(5)

