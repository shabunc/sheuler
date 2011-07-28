#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(a, q, b)
    local m = q - a^2
    print(m)
end

step(4, 23, 1)
