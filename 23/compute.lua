#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function kind(n)
    local sn = array.reduce(numeric.proper_divisors(n), function(a,b) return a + b end)
    return numeric.sign(sn - n), sn
end

function get_abundant(max)
    local res = {}
    for n = 1, max do
        if kind(n) == 1 then
            table.insert(res, n)
        end
    end
    return res
end

function get_cans(max)
    local cans = {}
    local cannots = {}
    local abundants = get_abundant(max)
    local it = numeric.combinations_iterator(2, abundants)
    print("found", #abundants, "abundants")
    for j = 1, #abundants do
        for i = 1, #abundants do
            cans[abundants[i] + abundants[j]] = 1
        end
    end
    return cans
end

assert(kind(28) == 0) 

function problem23(max) 
    local cans = get_cans(max)
    local res = 0
    for j = 1, max do
        if not cans[j] then
            res = res + j
        end
    end
    print(res)
end

problem23(28123)
