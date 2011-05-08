#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(n)
    local digs = numeric.digits(n)
    local sum = array.reduce(digs, function(a, b) return a + numeric.factorial(b) end)
    return sum
end

function chain(n) 
    local res = {n}
    while true do
        local next_n = step(res[#res])
        for j = #res, 1, -1 do
            if res[j] == next_n then
                return res
            end
        end
        table.insert(res, next_n)
    end
end

function problem74(max, len)
    local total = 0
    for n = 1, max - 1 do
        local ch = chain(n)
        --print(n, #ch)
        if #ch == len then
            print(n)
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end

assert(table.concat(chain(69)," ") == "69 363600 1454 169 363601")

problem74(100000, 60)
