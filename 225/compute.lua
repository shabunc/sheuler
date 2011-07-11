#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
memoize = require("memoize")

function tris(n)
    if n == 1 or n == 2 or n == 3 then
        return 1
    end
    return tris(n - 1) + tris(n - 2) + tris(n - 3)
end
tris = memoize(tris)

function collect(max)
    local n = 1
    while tris(n) < max do
        n = n + 1
    end
end


collect(10^9)
