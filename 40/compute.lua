#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function n_digits_card(n)
    if n == 1 then
        return 9
    end
    local res = 9 * 10^(n-1) - 1
    return res
end  

function nth(n)
    if n < 10 then
        return n
    end 
    local step = 0
    local m = {n}
    local card = {}
    repeat
      step = step + 1
      table.insert(card, step * n_digits_card(step))
      table.insert(m, m[#m] - step * n_digits_card(step))
    until m[#m] < 0
    print(step)
    local pos = card[#card] + m[#m] - 1
    local rem = pos % step
    local num = 10^(step-1) + (pos - rem) / step
    local digs = numeric.num2digits(num)
    return digs[rem + 1]
end

function brute(n)
    local res = {}
    for j = 1, n do
        local digs = numeric.num2digits(j)
        while digs[1] do
            table.insert(res, table.remove(digs, 1))
        end
    end
    print(#res)
    return res
end

local br = brute(200000)
local all = array.map({1,10,100,1000,10000,100000,1000000}, function(n) return br[n] end)
local ball = array.map({1,10,100,1000,10000,100000,1000000}, function(n) return nth(n) end)
local res = all:reduce(function(a, b) return a*b end, 1)
print(table.concat(all, " "), res)
print(table.concat(ball, " "))
--[[
local all = {1,10,100,1000,10000,100000,1000000}
all = array.map(all, function(v) return nth(v) end)
print(table.concat(all," "))
print(array.reduce(all, function(a,b) return a*b end, 1))
]]
