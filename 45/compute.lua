#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function pentas(n)
    return n * (3*n - 1) * 0.5
end

function tris(n)
    return (n * (n + 1) * 0.5)
end

function hexas(n)
    return (n * (2 * n - 1))
end

local pn, tn, hn = 1, 1, 1
local p, t, h = pentas(pn), tris(tn), hexas(hn)
while true do
    while t < p do
        tn = tn + 1
        t = tris (tn)
    end
    while h < p do
        hn = hn + 1
        h = hexas(hn)
    end
    if t == p and h == p then
        print(p, h, t)
    end
    pn = pn + 1
    p = pentas(pn)
end
