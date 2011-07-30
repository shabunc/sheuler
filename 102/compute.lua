#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

dofile("triangles.txt")

function scalar(a, b)
    return  a[1] * b[1] + a[2] * b[2]
end

function norm(a) 
    return math.sqrt(a[1]^2 + a[2]^2)
end

function cos(a, b)
    return scalar(a, b) / (norm(a) * norm(b))
end


function good(a, b, c) 
    local zero = {0, 0}
    local ab = math.acos(cos(a, b))
    local ac = math.acos(cos(a, c))
    local bc = math.acos(cos(b, c))
    local sum = ab + ac + bc
    if (sum == 2 * math.pi) then
        return true
    end
    return false
end

assert(good({-340, 495},{-153, -910}, {835, -947}) == true)
assert(good({-175, 41},{-421, -714}, {574, -645}) == false)
