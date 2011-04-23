#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("pascal")
require("bigint")

function brute(n) 
    return (array.reduce(numeric.num2digits(numeric.factorial(n)), function(a, b) return a + b end))
end

function digits(n) 
    local res = {}
    for j = 1, n do
        table.insert(res, j)
    end
    return res
end

function skip_tens(res) 
    local two_awaiting
    local five_awaiting
    local found = false
    for j = 1, #res do
        if res[j] % 5 == 0 then
            five_awaiting = j
        end
        if res[j] % 2 == 0 then
            two_awaiting = j
        end
        if five_awaiting and two_awaiting then
            found = true
            res[five_awaiting] = res[five_awaiting] / 5
            res[two_awaiting] = res[two_awaiting] / 2
            five_awaiting, two_awaiting = false, false
        end
    end
    return res, found
    --[[
    local prod = array.reduce(res, function(a, b) return a * b end, 1)
    return array.reduce(numeric.num2digits(prod), function(a, b) return a + b end), found
    ]]
end

function silly_reduce(t)
   local found
   while true do
        t, found = skip_tens(t)
        print(table.concat(t, " "))
        if not found then
            break
        end
   end
   local prod = array.reduce(t, function(a, b) return a * b end, 1)
   local sum = array.reduce(numeric.num2digits(prod), function(a, b) return a + b end), found
   print(sum)
end

--print(skip_tens(digits(n)), brute(n))
--silly_reduce(digits(n))

--[[
local a = bigint:new{1,1,1,1}
local b = bigint:new{1,0,9}
print(b:times(3))
]]


function crazy_factorial(n)
    local res = bigint:new{1}
    for j = 2, n do
        res = res:times(j)
        print(j, res)
    end
    return res
end

print(array.reduce(crazy_factorial(100).num, function(a, b) return a + b end))

