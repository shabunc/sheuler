#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(n)
    local divs = numeric.proper_divisors(n)
    local sum = array.reduce(divs, function(a,b) return a + b end)
    return sum
end

function chain(n, max) 
    local m = n
    local len = 0
    local prev = -1
    while true do
        m = step(m)
        if m == prev then
            return -1
        end
        if m == n then
            break
        end
        if m > max then
            break
        end
        len = len + 1
        prev = m
    end
    return len
end

function problem95(max) 
    local maxlen, maxn = -1, -1
    for n = 1, max do
        print(n, chain(n, max))
    end
end

assert(step(28) == 28)
assert(step(220) == 284)
assert(chain(12496, 10^6) == 4)


chain(562, 10^3)
