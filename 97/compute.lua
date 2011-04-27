#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function base2(n) 
    local res = {}
    while n ~= 0 do
       local rem = n % 2
       n = math.floor(n/2)
       table.insert(res, 1, rem)
    end
    return bigint:new(res, 2)
end

function problem97(a, n) 
    local a = base2(a)
    print("a is", a)
    local b = {1}
    for j = 1, n do
        table.insert(b, 0)
    end
    b = bigint:new(b, 2)
    print("b has been formed and consists of", b:len(), "digits")
    local it = a:mul_iterator(b)
    while true do
        local seq, continue  = it()
        print(seq)
        if not continue then
            break
        end
    end
end 


--problem97(28433, 30000)
--problem97(2343434,12)
--[[
local a = array:new({1,2,3})
local b = array:new({1,2,3})
print(a:map(function(a) return a*a end):reduce(function(a,b) return a + b end))
b:remove()
b:remove()
b:insert(2):insert(3):insert(7)
print(a,b)
]]

local b = bignum:new(2)
local a = bignum:new({2,2})
print(a)
