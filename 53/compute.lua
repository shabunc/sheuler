#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function less_then(n, k, max)
    local res = 1
    for j = 1, k - 1 do
        res = res * (n - j + 1)
    end
    return res
end

print(less_then(5,3))
