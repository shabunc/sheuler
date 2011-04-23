#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("bigint")

function problem16(n)
    local a = bigint:new{2}
    for j = 1, n - 1 do
        a = a:times(2)
    end
    return a, array.reduce(a.num, function(a,b) return  a + b end)
end

print(problem16(1000))
