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

function fast_problem179(max)
    local divs = {}
    for j = 2, max - 1 do
        print(j)
        local m = 1
        while true do
            local n = m * j
            if n > max then
                break
            end
            if not divs[n] then
                divs[n] = 0
            end     
            divs[n] = divs[n] + 1
            m = m + 1
        end
    end
    local count = 0
    for j = 2, max - 1 do
        if divs[j] == divs[j + 1] then
            count = count + 1
        end
    end 
    print("TOTAL", count)
    return count
end

local N = 10 ^ 7
--problem179(N)
fast_problem179(N)
