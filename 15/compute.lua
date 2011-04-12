#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

local cached = {}

function f(a, b, n, m) 
    if not cached[a] then
        cached[a] = {}
    end
    if cached[a][b] then
        return cached[a][b]
    end
    if a == n  and b == m then
        return 0
    elseif a == n then
        return 1
    elseif b == m then
        return 1
    else 
        local res = f(a + 1, b, n, m) + f(a, b + 1, n, m)
        cached[a][b] = res
        return res
    end
end

function problem15(n) 
    print(f(0,0,n,n))
end

problem15(20)
