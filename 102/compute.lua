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
    if (math.abs(sum - 2 * math.pi) < 0.000001) then
        return true
    end
    return false
end

function problem102(data)
    local count = 0
    for _, tr in ipairs(data) do
       local a = {tr[1], tr[2]} 
       local b = {tr[3], tr[4]} 
       local c = {tr[5], tr[6]} 
       local test = good(a, b, c)
       if test then
            count = count + 1
       end
    end
    return count
end

assert(good({-340, 495},{-153, -910}, {835, -947}) == true)
assert(good({-175, 41},{-421, -714}, {574, -645}) == false)

print(problem102(TRIANGLES))
