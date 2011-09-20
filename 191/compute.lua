#!/usr/bin/env lua

function OA(n) 
    if n < 3 then
        return 2^n
    end
    return 2^n - 2^(n - 2) + 1
end

function OAL(n)
    local res = OA(n) + 2 * OA(n - 1)
    for j = 1, n - 2 do
        local i = n - j - 1
        local part = OA(j) * OA(i)
        res = res + part
        print(i, j, part)
    end
    print("TOTAL", res)
    return res
end

OAL(4)
