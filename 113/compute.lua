#!/usr/bin/env lua 

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")
local memoize = require("memoize")

function bd(n, k)
    if n == 1 then
        return k + 1
    end
    if k == 0 then
        return 1
    end
    local res = 0
    res = bd(n, k - 1) + bd(n - 1, k)
    return res
end

function f(n)
    local inc = bd(n, 8)
    local dec = bd(n, 9)
    local res = inc + dec - 10
    return res, inc, dec
end

function problem113(n)
    local total = 0
    for k = 1, n do
        total = total + f(k)
    end
    return total
end


assert(problem113(6) == 12951)
assert(problem113(10) == 277032)

bd = memoize(bd)

local now = os.clock()
print(problem113(100))
print(string.format("time: %.2f\n", os.clock() - now))
