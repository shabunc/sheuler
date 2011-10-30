#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
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
    local it = {}
    local max = -1
    for j = 1, #matrix do
       table.insert(it, j) 
    end
    while true do
       it = nextperm(it)
       if not it then
          break
       end
       local seq = apply_perm(matrix, it)
       local sum = array.reduce(seq, function(a, b) return a + b end)
       if sum > max then
            max = sum
        end
       print(sum, max)
    end
end

problem345(LILMATRIX)
