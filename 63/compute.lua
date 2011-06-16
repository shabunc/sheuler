#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function pow_len(len) 
    local n = 1
    local res = {}
    while true do
         local m = n ^ len
         local digs = numeric.digits(m)
         if #digs > len then
            break
         end
         if #digs == len then
            table.insert(res, m)
         end
         n = n + 1
    end
    return res
end

function pows() 
    local total = 0
    local n = 1
    while true do
        local pl = pow_len(n)
        if #pl == 0 then
            break
        end
        total = total + #pl
        print(n, #pl, table.concat(pl," "))
        n = n + 1
    end
    print("TOTAL", total)
    return total
end

pows()
