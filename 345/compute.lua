#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("iterator")
require("array")

dofile("data.lua")

tiny = {{7, 53}, {497, 383}}

function copy(t)
    local res = {}
    for j = 1, #t do 
        local val = t[j]
        if (type(val) == "table") then
            table.insert(res, copy(val))
        else 
            table.insert(res, val)
        end
    end
    return res
end

function remrow(t, j)
    local ct = copy(t)
    table.remove(ct, j)
    return ct
end

function remcol(t, j)
    local ct = copy(t)
    for i = 1, #ct do
        table.remove(ct[i], j)
    end
    return ct
end

function remove(t, i, j)
    return remrow(remcol(t, j), i)
end


function uid(t)
    local res = ""
    for j = 1, #t do
        res = res .. table.concat(t[j], " ") .. " X "
    end
    return res
end

function ranks(m)
    local res = {}
    local n = #m
    for i = 1, n do
            table.insert(res, {remove(m, i, 1), m[i][1]})
    end
    return res
end

local CACHE = {}

function msum(t, inner) 
    local key = uid(t)
    if CACHE[key] then
        return CACHE[key]
    end
    if #t == 1 then
        CACHE[key] = t[1][1]
        return t[1][1]
    end
    local rnk = ranks(t)
    local res = {}
    for j = 1, #rnk do
        table.insert(res, msum(rnk[j][1], true) + rnk[j][2])
    end
    local max = res[1]
    for j = 2, #res do
        if res[j] > max then
            max = res[j]
        end
    end
    CACHE[key] = max
    print(max)
   return max
end

assert((msum(LILMATRIX) == 3315))
print(msum(BIGMATRIX))
