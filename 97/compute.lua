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
    return bignum(res, 2)
end

function problem97brute(a, n) 
    local a = bignum{2,8,4,3,3}
    local b = bignum{2}
    b = b:pow(n)
    c = a:mul(b)
    c = c:add(bigint(1))
    print(c)
end 


problem97brute(28433, 7830457)
--[[
local a = array:new({1,2,3})
local b = array:new({1,2,3})
print(a:map(function(a) return a*a end):reduce(function(a,b) return a + b end))
b:remove()
b:remove()
b:insert(2):insert(3):insert(7)
print(a,b)
]]
--[[
local b = bignum:new(2)
local a = bignum:new({2,2})
]]
--[[
local b = bignum{1,2,3,4}
print(b, b.base)
local c = b:copy()
print(c, c.base)
print(b:add(c))
print(b:mul(bignum{3}))
]]
