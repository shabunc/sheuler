#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function problem44(f)
    local chain = {}
    local nums = {}
    local n = 1
    while true do
        table.insert(nums, f(n))
        local b = nums[#nums]
        for j = #nums - 1, 1, -1 do
           local a = nums[j] 
           local found = array.index_of(nums, b - a)
           if found > 0 then
                chain[b] = a
                chain[a] = b - a
                if chain[b-a] then
                    print(b, a, b - a, chain[b-a])
                end
           end
        end
        if n > 10 then
            break
        end
        n = n + 1
    end
end

function penta(n)
    return n*(3*n - 1) * 0.5
end

problem44(penta)
