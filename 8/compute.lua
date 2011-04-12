#!/usr/bin/env lua

dofile "data.lua"
NUM = {}

for k,v in string.gmatch(DATA, ".") do
    table.insert(NUM, tonumber(k))
end 

function find(t, n) 
    local res = 0
    for j = 1, #t - n do
        local prod = 1
        for k = j, j + n - 1 do
            prod = t[k] * prod
        end
        if prod > res then
            res = prod
        end
    end
    return res
end

res = find(NUM, 5)
print(res)

