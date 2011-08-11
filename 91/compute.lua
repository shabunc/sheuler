#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function scalar(a, b)
    return a[1] * b[1] + a[2] * b[2]
end

function are_ortho(a, b)
    return scalar(a, b) == 0
end

function testpoints(a, b, c)
    --as for a
    local v1 = {b[1] - a[1], b[2] - a[2]}
    local v2 = {c[1] - a[1], c[2] - a[2]}
    if are_ortho(v1, v2) then
        return true, a
    end
    --as for b
    local v1 = {a[1] - b[1], a[2] - b[2]}
    local v2 = {c[1] - b[1], c[2] - b[2]}
    if are_ortho(v1, v2) then
        return true, b
    end
    --as for c
    local v1 = {a[1] - c[1], a[2] - c[2]}
    local v2 = {b[1] - c[1], b[2] - c[2]}
    if are_ortho(v1, v2) then
        return true, c
    end
    return false
end

function problem91(max)
    local total = 0
    for x1 = 0, max do
        for y1 = 0, max do
            for x2 = 0, max do
                for y2 = 0, max do
                    if not (x1 + y1 == 0) and not(x2 + y2 == 0) and not(x1 == x2 and y1 == y2) then
                        local test = testpoints({0, 0}, {x1, y1}, {x2, y2})
                        if (test) then
                            total = total + 1
                            print(x1, y1, x2, y2)
                        end
                    end
                end
            end
        end
    end
    print("TOTAL", total / 2)
    return total
end

problem91(50)
