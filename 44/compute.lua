#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")


function key(a,b)
    local res = a.." "..b
    return res
end

function problem44(f)
    local chain = {}
    local nums = {}
    local n = 1
    local min = math.huge
    while true do
        print(n)
        table.insert(nums, f(n))
        local b = nums[#nums]
        for j = #nums - 1, 1, -1 do
           local a = nums[j] 
           local found = array.index_of(nums, b - a)
           if found > 0 then
               if chain[key(a, b - a)] then
                    print(b, a, b - a, chain[key(a, b - a)])
                    return {b, a, b - a, chain[key(a, b - a)]}
               end
               chain[key(b, a)] = b - a
           end
        end
        if n > 3000 then
            break
        end
        n = n + 1
    end
end

function penta(n)
    return n*(3*n - 1) * 0.5
end

function triangle(n)
    return n * (n + 1) * 0.5
end

problem44(triangle)
