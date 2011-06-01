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

BADCACHE = {}
GOODCACHE = {}

function lych_step(bnum)
    return bnum:add(bnum:reverse()) 
end

function lych_test(bnum)
    local steps = math.huge
    local uid = tostring(bnum)
    if BADCACHE[uid] then
        return false
    end
    if GOODCACHE[uid] then
        return true
    end
    local it = bnum
    for step = 1, 50000 do
        print(bnum, step)
        it = it:add(it:reverse()) 
        if is_palindrome(it) then
            BADCACHE[uid] = true
            return false, step
        end
    end
    GOODCACHE[uid] = true
    return true, math.huge
end

function problem55()
    local total = 0
    for j = 1, 10000 do
        local num = bignum(numeric.digits(j))
        print(num)
        if lych_test(num) then
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end

assert(lych_test(bignum{3,4,9}) == false)

problem55()
