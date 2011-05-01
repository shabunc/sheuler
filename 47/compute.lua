#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function test_passed(n, m, len)
    local a = numeric.divisors(n)
    local b = numeric.divisors(m)
    local t = {}
    if #a ~= len or #b ~= len then
        return false
    end
    for j = 1, #a do 
        t[a[j][1]] = 1
    end
    for j = 1, #b do
        if t[b[j]] then
            return false
        end
    end
    return true
end

function test(n, len)
    local res = {n}
    for j = 1, len - 1 do
       table.insert(res, n + j)
       if not test_passed(res[#res-1], res[#res], len) then
            return false, j
       end
    end
    return res
end

function problem47(len)
    local n = 3
    while true do
        local res, skip = test(n, len)
        if res then
            print(table.concat(res," "))
            return res
        end
        n = n + skip
        print(n)
    end
end

assert(table.concat(problem47(2)," "), "14 15")
assert(table.concat(problem47(3)," "), "644 645 646")
problem47(4)
