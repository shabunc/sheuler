#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")

function rad(n) 
    local divs = numeric.divisors(n)
    local res =  array.map(divs, function(it) return it[1] end)
                 :reduce(function(a, b) 
                    return a * b
                end, 1)
    return res
end

function radpairs(n)
    local res = {}
    for j = 1, n do
        print(j)
        table.insert(res, {j, rad(j)})
    end
    for _, v in ipairs(res) do
    end
    return res
end

function radsort(a, b)
    if a[2] == b[2] then
        return a[1] < b[1]
    end
    return a[2] < b[2]
end

function problem124(n)
    local rs = radpairs(n)
    table.sort(rs, radsort)
    return rs
end

assert(problem124(10)[4][1] == 8)
assert(problem124(10)[6][1] == 9)

print(problem124(100000)[10000][1])
