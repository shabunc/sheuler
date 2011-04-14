#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function problem31(n, t)
    local iterator = numeric.partitions_iterator(n, t, 1)
    local total = 0
    while true do
        local p = iterator()
        if not p then 
            break
        end
        local s = ""
        local check = 0
        total = total + 1
        for i, v in ipairs(p) do
            s = s.." "..v[1].."*"..v[2] 
            check = check + v[1] * v[2]
        end
        print(s, check)
        assert(check == n)
    end
    print(total)
    return total
end

problem31(200, {200, 100, 50, 20, 10, 5, 2, 1})
