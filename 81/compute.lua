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

function borrow(b, a)
    return setmetatable(b, {
        __index = function(self, key)
            return rawget(self, key) or a[key]
        end
    })
end  

function sumrect(rect)
    local r = borrow({}, rect)
    for row = #rect - 1, 1, -1 do
        for j = #rect[row] - 1, 1, -1 do
            r[row][j] = rect[row][j] + math.min(rect[row + 1][j], rect[row][j + 1]) + r[row + 1][j + 1]
            print(row, j, r[row][j])
        end
    end
    return r
end

print(sumrect(TINYRECT)[1][1])
print(sumrect(LILRECT)[1][1])
