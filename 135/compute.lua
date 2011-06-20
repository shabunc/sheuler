#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function solcount(n) 
    local count = 0
    local divs = numeric.proper_divisors(n)
    if #divs < 10 then
        return -1
    end
    local misses_limit = #divs - 10
    local misses_count = 0
    for _, a in ipairs(divs) do
        local d = (n/a + a)
        if d % 4 == 0 and d/4 < a then
            count = count + 1
        else
            if misses_count == misses_limit then
                print("exceeding misses limit")
                return -1
            end
            misses_count = misses_count + 1
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
