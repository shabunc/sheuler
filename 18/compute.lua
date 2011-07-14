#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")


local LILTREE = {
{3},
{7, 4},
{2, 4, 6},
{8, 5, 9, 3}
}
--[[
{3}}
{10}, {7}
{12}, {14, 11}, {13}
{20}, {7, 19, 16}, {23, 20, 22}, {16}
]]


local TREE = {
{75},
{95, 64},
{17, 47, 82},
{18, 35, 87, 10},
{20, 04, 82, 47, 65},
{19, 01, 23, 75, 03, 34},
{88, 02, 77, 73, 07, 63, 67},
{99, 65, 04, 28, 06, 16, 70, 92},
{41, 41, 26, 56, 83, 40, 80, 70, 33},
{41, 48, 72, 33, 47, 32, 37, 16, 94, 29},
{53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14},
{70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57},
{91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48},
{63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31},
{04, 62, 98, 27, 23, 09, 70, 98, 73, 93, 38, 53, 60, 04, 23}
}

function addthese(val, ...)
    local max = -1
    local res = {}
    for _, t in ipairs{...} do
        for _, v in ipairs(t) do
            local s = val + v
            if s > max then
                max = s
            end 
            table.insert(res, s)
        end
    end
    return res, max
end

function sum(n, tree)
    local max = -1
    local row  = tree[n]
    if n == 1 then
        return {{row[1]}}
    end
    local res = {}
    local prevs = sum(n - 1, tree)
    for j = 1, #row do
        local cell, m = addthese(row[j], prevs[j - 1] or {} , prevs[j] or {})
        if m > max then
            max = m
        end
        print(table.concat(cell, " "))
        table.insert(res, cell)
    end
    print("MAX", max)
    return res
end

function problem18(tree)
    return sum(#tree, tree)
end

problem18(TREE)
