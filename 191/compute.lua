#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
memoize = require("memoize")

function tribonacci(n)
    if n == 1 or n == 2 then
        return 0
    end
    if n == 3 then
        return 1
    end
    return tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)
end
tribonacci = memoize(tribonacci)

function OA(n) 
    --actually, this is tribonacci as well
    if n == 1 then
        return 2
    end
    return 2 * OA(n - 1) - tribonacci(n) 
end

--[[
function OA(n)
    if n < 3 then
        return 2^n
    end
    return 2^n - 2^(n-2) + 1
end
]]


function OAL(n)
    local res = OA(n) + 2 * OA(n - 1)
    print(OA(n), OA(n - 1), res)
    for j = 1, n - 2 do
        local i = n - j - 1
        local part = OA(j) * OA(i)
        res = res + part
        print(i, j, part)
    end
    print("TOTAL", res)
    return res
end

OAL(30)
