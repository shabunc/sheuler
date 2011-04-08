#!/usr/bin/env lua

function getdigits(num)
    local iterator = num
    local res = {}
    for i = math.ceil(math.log10(num+1)) - 1,0,-1 do
        local digit =  math.floor(iterator/(10^i))
        table.insert(res, digit)
        iterator = iterator - digit * 10^i
    end
    return res
end

function is_palindrome(num)
    local digits = getdigits(num)
    for j = 1, math.ceil(#digits/2) do
        if digits[j] ~=  digits[#digits - j + 1] then
            return false
        end
    end
    return true, num
end

function test_ab(a,b) 
    return is_palindrome(a*b)
end

function problem(from, to) 
    local a,b
    local pal
    local res = 0
    local pal_divisor = 11
    for j = math.floor(to/pal_divisor) * pal_divisor, from, -pal_divisor do
        for i = to, from, -1 do
            local is_pal
            is_pal, pal  = test_ab(j, i)
            if is_pal and pal > res then
                a, b = j, i
                res = pal
            end
        end
    end
    return a, b, res
end

a, b, palindrome = problem(100, 999)
print(a, b, a*b)
