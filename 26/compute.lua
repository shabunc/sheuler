#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(n)
    local len =  math.floor(math.log10(n)) + 1
    local a = 10 ^ len
    return a % n
end

function problem26(max)
    for n = 2, (max - 1) do
        print(n, string.format("%.50f", 1/n))
        print("=====")
    end
end

