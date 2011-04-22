#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function stat_for_seq(t)
    local res = {
       [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0
    }
    for j = 1, #t do
        res[t[j]] = res[t[j]] + 1
    end
    return res
end

function problem111(n)
    local M = {[n] = {}}
    local N = {[n] = {}}
    for j = 0, 9 do
        M[n][j] = 0
        N[n][j] = {}
        for k = 0, 9 do
            N[n][j][k] = {}
        end
    end

    local start = {1}
    for j = 2, n do
        table.insert(start, 0)
    end
    local it = numeric.integer_iterator(start)
    while true do
        local seq = it()
        it()
        if #seq > n then
            break
        end
        if seq[#seq] ~= 5 then
            local num_seq = numeric.digits2num(seq)
            if numeric.is_prime(num_seq) then
                print(num_seq)
                local stat = stat_for_seq(seq)
                for j = 0, 9 do 
                    if M[n][j] < stat[j] then
                        M[n][j] = stat[j]
                    end
                    table.insert(N[n][j][stat[j]], num_seq)
                end
            end
        end
    end

    local res = 0
    local sum = function(a,b) return a + b end
    for j = 0, 9 do
        local _n = N[n][j][M[n][j]]
        local s = array.reduce(_n, sum)
        res = res + s
        print(j, M[n][j], #_n, s)
    end
    print(res)
    return res
end

problem111(10)
