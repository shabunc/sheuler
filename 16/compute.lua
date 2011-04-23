#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("bigint")

function problem16(n)
    local a = (bigint:new{2}):pow(n)
    return a, array.reduce(a.num, function(a,b) return  a + b end)
end

print(problem16(1000))
