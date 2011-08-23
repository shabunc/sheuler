#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function invert(n)
    local r = 1
    local res = {} 
    local rems = {}
    while true do
        table.insert(res, math.floor((10 * r) / n))
        r = (10 * r ) % n
        if not rems[r] then
            rems[r] = 1
        else 
            return res, #rems
        end
    end
end

function problem26(n)
    local maxlen = -1
    local max
    for j = 2, n do
        local digs, len = invert(j)
        print(j, len, table.concat(digs))
        if len > maxlen then
            maxlen = len
            max = j
        end
    end
    print("MAX ", max, maxlen)
    return max, maxlen
end

problem26(1000)
