#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")

function allsquares(len, max) 
    local from = 1
    local res = {}
    while true do
        local total = 0
        for j = from, from + len do
            total = total + j*j        
            if total > max then
                return res
            end
        end
        table.insert(res, total)
        from = from + 1
    end
end

print(table.concat(allsquares(3, 100), " "))
