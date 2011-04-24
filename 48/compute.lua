#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("bigint")


function problem48(n) 
    local total = bigint:new{1}
    local it = bigint:new{1}
    for j = 2, n do
        it = it:add(bigint:new{1})
        local sum = it:pow(j)
        print(sum)
        total = total:add(sum)
    end
    return total
end 

--assert(numeric.digits2num(problem48(10).num) == 10405071317)
print("TOTAL", problem48(1000))
