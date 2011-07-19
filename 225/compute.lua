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
    local res = {}
    while tris(n) < max do
        local divs = numeric.propers(tris(n))
        for _, d in ipairs(divs) do
            table.insert(res, d)
        end
        n = n + 1
    end
    table.sort(res)
    res = array.uniq(res)
    return res
end

function problem225(n)
    local divs = collect(2 * 10^17)
    local count = 0
    print("found ", #divs)
    for j = 1, divs[#divs], 2 do
        found = array.index_of(divs, j)
        if found == 0 then
            print(count, j, found)
            count = count + 1
            if count  == n  then
                break
            end
        end
    end
end

problem225(124)

