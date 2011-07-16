#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

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

function sumrect(rect, n, m)
    if n == #rect then
        local res = 0
        for j = m, #rect[n] do
            res = res + rect[n][j]
        end
        return res
    end
    if m == #rect then
        local res = 0
        for j = n, #rect do
            res = res + rect[j][m]
        end
        return res
    end
    return rect[n][m] + math.min(sumrect(rect, n + 1, m), sumrect(rect, n, m + 1))
end

function problem81(rect)
    return sumrect(rect, 1, 1)
end

print(problem81(TINYRECT))
print(problem81(LILRECT))
print(problem81(RECT))
print(problem81(BIGRECT))
