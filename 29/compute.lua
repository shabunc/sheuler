#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function problem29(a, b)
    local res = {}
    for j = 2, a do
        for i = 2, b do
            array.insert_sorted(res, j^i)
        end
    end
    print(#res)
    return res
end

problem29(100, 100)
