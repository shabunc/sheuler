#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function f(n) 
    for j = 1, math.huge do 
        local m = j * n
        print(j, m)
        local digs = numeric.digits(m)
        if array.every(digs, function(d) return d <3 end) then
            return m, j
        end
    end
end

function ff(n)
    local total = 0
    for j = 1, n do
        local _, k = f(j)
        print(j, _)
        total = total + k
    end
    return total
end

print(f(99))
