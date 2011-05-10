#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function pentas(n)
    return n * (3*n - 1) * 0.5, n + 1
end

function tris(n)
    return (n * (n + 1) * 0.5), n + 1
end

function hexas(n)
    return (n * (2 * n - 1)), n + 1
end

local p, pn = pentas(1)
local t, tn = tris(1)
local h, hn = hexas(1)
while true do
    while t < p do
        t, tn = tris (tn)
    end
    while h < p do
        h, hn = hexas(hn)
    end
    if t == p and h == p then
        print(p, h, t)
    end
    p, pn = pentas(pn)
end
