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
    local len = 0
    local total = 0
    while true do
        local next_total = total + len * n_digits_card(len)
        if next_total >= n then
            break
        end
        len = len + 1
        total = next_total
    end
    local num = math.floor((n - total + 1)/len) + total 
    local dig = (n - total + 1) % len + 1
    local digits = numeric.num2digits(num)
    return digits[dig]
end

print(nth(10))
--[[
local all = {1,10,100,1000,10000,100000,1000000}
all = array.map(all, function(v) return nth(v) end)
print(table.concat(all," "))
print(array.reduce(all, function(a,b) return a*b end, 1))
]]
