#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function stat_for_seq(t)
    local res = {
       [-1] = 0, [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0
    }
    local prev = -1
    local candidate = 0
    for j = 1, #t do
        if t[j] == prev then
            candidate = candidate + 1
        else
            if res[prev] < candidate then
                res[prev] = candidate
            end
            candidate = 1
        end
        prev = t[j]
    end
    if res[t[#t]] < candidate then
        res[t[#t]] = candidate
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

    for j = 0, 9 do
        print(j, M[n][j], table.concat(N[n][j][3], " "))
    end
end

problem111(4)
