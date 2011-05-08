#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(n)
    local digs = numeric.digits(n)
    local sum = array.reduce(digs, function(a, b) return a + numeric.factorial(b) end)
    return sum
end

local CACHE = {}

function chain(n) 
    local res = {n}
    while true do
        local next_n = step(res[#res])
        if CACHE[next_n] then
            for j = 1, #CACHE[next_n] do
                table.insert(res, CACHE[next_n][j])
            end
            return res
        else
            for j = #res, 1, -1 do
                if res[j] == next_n then
                    CACHE[n] = res
                    return res
                end
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
            print(table.concat(ch," "))
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end

assert(table.concat(chain(69)," ") == "69 363600 1454 169 363601")
assert(#chain(78) == 4)
assert(#chain(145) == 1)
assert(#chain(540) == 2)

problem74(1000000, 60)
