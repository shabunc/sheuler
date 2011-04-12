#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

--нечётные палиндромы, но вообще фиг с ними
function bin_palindroms(n, n_caller) 
    if n == 1 then
        return {{0}, {1}}
    end
    local res = {}
    for j = 1, n-1 do
        pals = bin_palindroms(n - j, n_caller)
        for _,p in ipairs(pals) do
            table.insert(p, 1, 1)
            table.insert(p, 1)
            for k = 1, j - 1 do
                table.insert(p, 2, 0)
                table.insert(p, #p, 0)
            end
            table.insert(res, p)
            if n_caller == n then
                coroutine.yield(p)
            end
        end
    end
    if n_caller ~= n then
        return res
    end
end

function bin_pal_iterator(n) 
    return coroutine.wrap(function() 
        return bin_palindroms(n,n)
    end)
end

function is_pal(t) 
    for j = 1, math.floor(#t/2) do
        if t[j] ~= t[#t - j + 1] then
            return false
        end
    end
    return true
end

function palindrom_generator(n) 
    if n == 0 then
        return {{}}
    end
    if n == 1 then
        return {{0},{1}}
    end
    if n % 2 == 0 then
        local seq_iterator = numeric.integer_iterator({0}, 2) 
        local len =  (n - 2) / 2
        while true do
            local seq = seq_iterator()
            if #seq > len then
                break
            end
            local res = {1, 1}
            for j = 1, #seq do
                table.insert(res, j + 1, seq[j]) 
                table.insert(res, #res - j, seq[j]) 
            end
            if #seq == len then
                print(table.concat(res))
            end
        end
    else
    end 
end

palindrom_generator(8)

--[[
local pals = numeric.integer_iterator({0}, 3)
local count = 0
while true do
    p = pals()
    if count > 30 then
        break
    end
    count = count + 1
    print(table.concat(p))
end
]]
