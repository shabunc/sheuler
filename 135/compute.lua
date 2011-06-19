#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function solcount(n) 
    local count = 0
    for a = 1, n do
        if n % a == 0 then
            local d = (n/a + a)
            if d % 4 == 0 then
                if d/4 < a then
                    count = count + 1
                end
            end
        end
    end
    return count
end

function problem135(max)
    local total = 0
    for n = 1, max do
        print(n)
        if solcount(n) == 10 then
            total = total + 1
        end
    end
    return total
end

assert(solcount(1155) == 10)

print("TOTAL", problem135(10^6))
