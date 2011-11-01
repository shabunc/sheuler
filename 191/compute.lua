#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
memoize = require("memoize")

function trinobacci(n)
    if n == 1 or n == 2 then
        return 0
    end
    if n == 3 then
        return 1
    end
end
tribonacci = memoize(tribonacci)

function OA(n) 
    return tribonacci(n + 4)
    --[[
    --actually, this is tribonacci as well
    if n == 1 then
        return 2
    end
    return 2 * OA(n - 1) - tribonacci(n) 
    ]]
=======
    return trinobacci(n - 1) + trinobacci(n - 2) + trinobacci(n - 3)
end
trinobacci = memoize(trinobacci)

function OA(n) 
    if n == 1 then
        return 2
    end
    return 2 * OA(n - 1) - trinobacci(n) 
>>>>>>> a4420e1c17f851e14656ade58751ed26bf35fc0e
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
