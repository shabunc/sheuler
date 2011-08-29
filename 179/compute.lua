#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")


function problem179(max)
    local da
    local db = numeric.propers(2)
    local count = 0
    for j = 3, max - 1 do
        da = db
        db = numeric.propers(j)
        if #da == #db then
            count = count + 1
            print(j, j - 1)
        end
    end
    print("TOTAL", count)
    return count
end

problem179(10 ^ 7)
