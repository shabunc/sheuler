#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
memoize = require("memoize")

RECT = {
    {131, 673, 234, 103, 18},
    {201, 96,  342, 965, 150},
    {630, 803, 746, 422, 111},
    {537, 699, 497, 121, 956},
    {805, 732, 524, 37,  331}
}

LILRECT = {
    {746, 422, 111},
    {497, 121, 956},
    {524, 37,  331}
}

TINYRECT = {
    {121, 956},
    {37,  331}
}

BIGRECT = dofile("matrix.txt")

function brute(rect, n, m)
    if n == 1 then
        local res = 0
        for j = m, 1, -1 do
            res = res + rect[n][j]
        end
        return res
    end
    if m == 1 then
        local res = 0
        for j = n, 1, -1 do
            res = res + rect[j][m]
        end
        return res
    end
    return rect[n][m] + math.min(brute(rect, n - 1, m), brute(rect, n, m - 1))
end
brute = memoize(brute)

function problem81(rect)
    local lim = #rect
    return brute(rect, lim, lim)
end

print(problem81(TINYRECT))
print(problem81(LILRECT))
print(problem81(RECT))
print(problem81(BIGRECT))
