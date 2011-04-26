#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function test_right(t) 
    for j = #t, 1, -1  do
        local a = array.copy(t, 1, j) 
        local n = numeric.digits2num(a)
        if not numeric.is_prime(n) then
            return false
        end
    end
    return true
end

function test_left(t)
    for j = 1, #t do
        local a = array.copy(t, j) 
        local n = numeric.digits2num(a)
        if not numeric.is_prime(n) then
            return false
        end
    end
    return true
end


function problem37()
    local num = 11
    local res = {}
    while true do
        num = num + 2
        if numeric.is_prime(num) then
            local digits = numeric.num2digits(num)
            if test_left(digits) and test_right(digits) then
                print(num)
                table.insert(res, num)
            end
        end
        if #res == 11 then
            break
        end
    end
    print(table.concat(res, " "))
    print("total", array.reduce(res, function(a, b) return a + b end))
    return res
end

problem37()
--[[
]]
