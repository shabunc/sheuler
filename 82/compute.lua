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


function brute(rect, n, m, stop_n, stop_m)
    print(n, m)
    if n == 0 or m == 0 or n > #rect then
        return math.huge
    end
    if m == 1 then
        return rect[n][m]
    end
    return rect[n][m] + math.min(brute(rect, n - 1, m), brute(rect, n, m - 1), brute(rect, n + 1, m))
end
brute = memoize(brute)

function problem81(rect)
    local lim = #rect
    return brute(rect, lim, lim, 1, 1)
end

print(problem81(LILRECT))
--[[
print(problem81(TINYRECT))
print(problem81(RECT))
]]
