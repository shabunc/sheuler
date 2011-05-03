#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

dofile("triangles.txt")

function scalar(a, b)
    return  a[1] * b[1] + a[2] * b[2]
end

function good(a, b, c) 
    local ab = scalar(a, b)
    local ac = scalar(a, c)
    local bc = scalar(b, c)
    print(ab, ac, bc)
    return ab < 0 and ac < 0  and bc < 0
end

assert(good({-340, 495},{-153, -910}, {835, -947}) == true)
