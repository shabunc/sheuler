#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

MAX = 10^6
CHAINLOOKUP = {}

function step(n)
    local divs = numeric.proper_divisors(n)
    local sum = array.reduce(divs, function(a,b) return a + b end)
    return sum
end

function chain(n, prevt) 
    if CHAINLOOKUP[n] then
        return CHAINLOOKUP[n]
    end
    prevt = prevt or {n}
    local m = step(n)
    local found = array.index_of(prevt, m)
    if found == 1 then
        return #prevt
    end
    if found > 1 or m > MAX then
        return -1
    end
    table.insert(prevt, m)
    local res = chain(m, prevt)
    CHAINLOOKUP[n] = res
    return res
end

function problem95(max) 
    local maxlen, maxn = -1, -1
    for n = 1, max do
        print(n)
        local len = chain(n)
        if len > maxlen then
            maxlen = len
            maxn = n
            print(n, len)
        end
    end
    print(maxn, maxlen)
end

assert(step(28) == 28)
assert(step(220) == 284)

problem95(MAX)
