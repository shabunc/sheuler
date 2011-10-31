#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("iterator")
require("array")

dofile("data.lua")

function nextperm(a) 
    local res = {}
    --copy
    for j = 1, #a do
        table.insert(res, a[j])
    end
    local k = #a - 1
    --find such k that a[k] < a[k + 1] > a[k] > ... > a[n]
    while a[k] > a[k + 1] do
        k = k - 1
        if k == 0 then
            return false
        end
    end
    local m = #a 
    --find such m that it it the least a[m] such that a[m] > a[k]
    while a[m] < a[k] do
        m = m - 1
    end
    res[k], res[m] = res[m], res[k]
    --revert
    local swap = {}
    for j = k + 1, #a do
        table.insert(swap, table.remove(res)) 
    end
    for j = 1, #swap do
        table.insert(res, table.remove(swap))
    end
    return res
end

function apply_perm(matrix, perm) 
    local res = {}
    for j = 1, #perm do
        table.insert(res, matrix[j][perm[j]]) 
    end
    return res
end

function problem345(matrix) 
    --brute
    local range = {}
    local max = -1
    for j = 1, #matrix do
       table.insert(range, j) 
    end
    local it = iterator.perm_lex(range)
    while true do
       local seq =  it()
       if not seq then
          break
       end
       local cseq = apply_perm(matrix, seq)
       local sum = array.reduce(cseq, function(a, b) return a + b end)
       if sum > max then
            --print(table.concat(seq," "), sum)
            max = sum
        end
    end
    return max
end

function tupstring(self)
    local str = ""
    for j = 1, #self do
        str = str .. "(" .. self[j][1] .. "," .. self[j][2] ..")"
    end
    return str
end

function prepare(t)
    local res = {}
    for j = 1, #t do
        table.insert(res, {t[j], j})
    end
    table.sort(res, function(a, b) 
        return a[1] > b[1]
    end)
    return setmetatable(res,{
        __tostring = tupstring
    });
end

function prepare_all(m) 
    local res = array(m):map(prepare)
    return setmetatable(res, {
        __tostring = function(self) 
            local str = ""
            for j = 1, #self do
                str = str .. tostring(self[j]) .. "\n" 
            end
            return str
        end
    })
end

function inc(t, maxdig)
    local k = #t
    while t[k]  == maxdig do
        t[k] = 1
        k = k - 1
    end
    if k == 0 then
        return false
    end
    t[k] = t[k] + 1
    return t
end

function slice(m, t)
    local res = {}
    for j = 1, #t do
        table.insert(res, m[j][t[j]])
    end
    return setmetatable(res, {
        __tostring = tupstring
    })
end

function is_good(t)
    local uniq = {}
    for j = 1, #t do
        if uniq[t[j][2]] then
            return false
        end
        uniq[t[j][2]] = 1
    end     
    return true
end

function ids(len)
    local res = {}
    for j = 1, len do
        table.insert(res, 1)
    end
    return res
end

function solve(m)
    local pm = prepare_all(m)
    local it = ids(#m)
    local max = -1
    while true do
        local sm = slice(pm, it)
        if is_good(sm) then
            local sum = array(sm):reduce(function(a, b) return a + b[1] end)
            if sum > max then
                print(sm)
                print(sum)
                max = sum
            end
        end
        it = inc(it, #m)
        if not it then
            break
        end
    end
end

solve(LILMATRIX)
