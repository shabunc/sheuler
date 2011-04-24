#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bigint")

function is_reversible(big)
    if big[big:len()] == 0 then
        return false
    end
    local test = big:add(big:revert())
    local res = true
    for j = 1, test:len() do
        if test[j] % 2 == 0 then
            res = false
            break
        end
    end
    return res
end 

function problem145(len)
    local total  = 0
    local big = bigint:new{1} 
    while big:len() < len do
        if is_reversible(big) then
            print(big)
            total = total + 1
        end
        big = big:add(bigint:new{1})
    end
    print("TOTAL", total)
    return total
end

assert(problem145(4) == 120)

problem145(9)
