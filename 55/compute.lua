#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")
require("bignum")

function is_palindrome(digits)
    for j = 1, math.ceil(#digits/2) do
        if digits[j] ~=  digits[#digits - j + 1] then
            return false
        end
    end
    return true, num
end

function lych_step(bnum)
    return bnum:add(bnum:reverse()) 
end

function lych_test(bnum)
    local steps = math.huge
    local it = bnum
    for step = 1, 50000 do
        it = it:add(it:reverse()) 
        if is_palindrome(it) then
            return false, step
        end
    end
    return true, math.huge
end

print(lych_test(bignum{3,4,9}))
