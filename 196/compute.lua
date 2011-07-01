#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function level(n)
    local res = {}
    local last = n * (n + 1) * 0.5
    for j = last - n + 1, last do
        table.insert(res, j)
    end
    return res
end

function S(n) 
    local up = level(n - 1)
    local mi = level(n)
    local lo = level(n + 1)
    for k, p in ipairs(mi) do
        if numeric.is_prime(p) then
            print(p)
            local upneighs = {up[k - 1] or 2, up[k] or 2, up[k + 1] or 2}
            local neighs = {mi[k - 1] or 2, mi[k + 1] or 2}
            local loneighs = {lo[k - 1] or 2, lo[k] or 2, lo[k + 1] or 2}
        end
    end
end

S(8)
