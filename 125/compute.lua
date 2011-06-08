#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")

function squares(len, max) 
    local from = 1
    local res = {}
    while true do
        local total = 0
        for j = from, from + len - 1 do
            total = total + j*j        
            if total > max then
                return res
            end
        end
        table.insert(res, total)
        from = from + 1
    end
end

function allsquares(max)
    local res = {}
    local len = 2
    while true do
        sqs = squares(len, max)
        if #sqs == 0 then
            break
        end
        for _, sq in ipairs(sqs) do
            table.insert(res, sq)
        end
        len = len + 1
    end
    return res
end

function is_palindrome(digits)
    for j = 1, math.ceil(#digits/2) do
        if digits[j] ~=  digits[#digits - j + 1] then
            return false
        end
    end
    return true, num
end

function problem125(max) 
    local pals = array.filter(allsquares(max), function(it) 
        return is_palindrome(numeric.digits(it))
    end):uniq()
    for _, v in ipairs(pals) do
        --print(v)
    end
    local res = pals:reduce(function(a, b) return a + b end)
    return res
end

assert(problem125(10^3) == 4164)

print(problem125(10^8))
