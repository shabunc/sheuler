#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("bigint")

function pow(n, m)
    local big = bigint:new(numeric.num2digits(n))
    for j = 1, m - 1 do
        big  = big:times(n)
    end
    return big
end

function problem48(n) 
    local total = bigint:new{1}
    for j = 2, n do
        print(j, pow(j,j))
    end
    return total
end 

--problem48(1000)
local a = bigint:new{9}
local b = bigint:new{9}

print(a:mul(b))
