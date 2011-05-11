#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

local NUMWORDS = {
    [1] = "one",
    [2] = "two",
    [3] = "three",
    [4] = "four",
    [5] = "five",
    [6] = "six",
    [7] = "seven",
    [8] = "eight",
    [9] = "nine",
    [10] = "ten",
    [11] = "eleven",
    [12] = "twelve",
    [13] = "thirteen",
    [15] = "fifteen",
    [18] = "eighteen",
    [20] = "twenty",
    [30] = "thirty",
    [40] = "forty",
    [50] = "fifty",
    [80] = "eighty"
}

function translate(n)
        local num = n
        if NUMWORDS[n] then
            return NUMWORDS[n]
        end
        local len = math.floor(math.log10(n))
        local res = ""
        local digit = math.floor(n/(10^len))
        n = n - digit * 10^len
        if len == 1 then
            if digit == 1 then
                res = translate(n) .. "teen"
            else 
                res = NUMWORDS[num - n] or (translate(digit) .. "ty")
                if n ~= 0 then
                    res = res .. "-" .. translate(n)
                end
            end
        end
        if len == 2 then
            res = translate(digit) .. " hundred"
            if n ~= 0 then
                res = res .. " and " .. translate(n)
            end
        end
        if len == 3 then
            res = translate(digit) .. " thousand"
            if n ~= 0 then
                res = res .. " and " .. translate(n)
            end
        end
        return res
end

function problem17()
    local total = 0
    for n = 1, 1000 do
        local tr = translate(n)
        local trtr = string.gsub(tr, "[%s-]", "")
        print(string.format("%i\t%s\t%s",n, trtr, tr))
        total = total + trtr:len()
    end
    print("TOTAL", total)
    return total
end

problem17()
