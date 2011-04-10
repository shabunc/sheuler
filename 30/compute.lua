#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")

function ascending(t, min, n, n_caller)
    if n == 0 then
        return {{}}
    end
    local res = {}
    for i = min, #t do
        local seqs  = ascending(t, i, n - 1, n_caller)
        for j, seq in ipairs(seqs) do
            table.insert(seq, 1, t[i])
            table.insert(res, seq)
            if  n == n_caller  then
                coroutine.yield(seq)
            end
        end
    end
    if n ~= n_caller then
        return res
    end
end

function ascending_iterator(t, n) 
    return coroutine.wrap(function() 
        return ascending(t, 1, n, n)
    end)
end

function seqs_for_n(n, pow)
    local iterator = ascending_iterator({0,1,2,3,4,5,6,7,8,9}, n)
    local pow_sum = function(a,b) return a + b^pow end
    local total = 0
    while true do
        local seq = iterator()
        if not seq then
            break
        end
        local sum = array.reduce(seq, pow_sum)
        local digits = numeric.num2digits(sum)
        local sorted = array.copy(digits)
        table.sort(sorted)
        if array.are_equal(sorted, seq) then
            total = total + sum
        end
    end
    return total
end

function problem30()
    local total = 0
    for j = 2, 9 do
        total = total + seqs_for_n(j, 5)
    end
    print(total)
end

problem30()
