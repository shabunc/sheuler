#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function problem44(f)
    local chain = {}
    local nums = {}
    local n = 1
    local min = math.huge
    while true do
        table.insert(nums, f(n))
        local b = nums[#nums]
        for j = #nums - 1, 1, -1 do
           local a = nums[j] 
           local found = array.index_of(nums, b - a)
           if found > 0 then
                chain[b] = a
                chain[a] = b - a
                if chain[b - a] and chain[chain[a] - chain[b - a]] then
                    local D = chain[chain[a] - chain[b - a]]
                    print(b, a, b - a, D)
                    if D < min then
                        min = D
                    end
                end
           end
        end
        if n > 3000 then
            break
        end
        n = n + 1
    end
    print("MIN", min)
end

function penta(n)
    return n*(3*n - 1) * 0.5
end

function triangle(n)
    return n * (n + 1) * 0.5
end

problem44(penta)
