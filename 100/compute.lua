#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

function is_good(n) 
    local a = math.sqrt(4*n + 1)
    return a == math.floor(a), (a/2 + 0.5)
end

function brute100(n)
    for j = 2, n, 2 do
        local a = j
        local b = 2*a 
        local good_a, _a = is_good(a)
        local good_b, _b = is_good(b)
        if good_a and good_b then
            print(a, _a, b, _b, _a/_b)
        end
    end
end

function brute100_2(n)
    for j = 1, n, 2 do
        for i = math.ceil(j/0.71), n, 2 do
            local a = j * (j - 1)
            local b = i * (i - 1)
            local c = b / a
            if c == 2 then
                print(j, i)
            end
        end
    end
end

brute100_2(1000000)
