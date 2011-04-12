#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

for j = 1000,1000 do
    num = 2 ^ j
    local digits = numeric.num2digits(num)
    local num10 = numeric.digits2num(digits)
    assert(num10 == 2^1000)
    local sum = array.reduce(digits, function(a,b) return a + b end)
    local check_sum = 0
    for i, v in ipairs(digits) do
        check_sum = check_sum + v
    end
    assert(check_sum, sum)
    print(sum)
end
