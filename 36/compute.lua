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
    local invert = function(t) 
        res = array.copy(t)
        for j = 2, #res - 1 do
            res[j] = (res[j] + 1) % 2
        end
        return res
    end
    if n == 0 then
        return {{}}
    end
    if n == 1 then
        coroutine.yield({1})
    end
    if n == 2 then
        coroutine.yield({1,1})
    end
    if n == 3 then
        coroutine.yield({1,0,1})
        coroutine.yield({1,1,1})
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
                coroutine.yield(res)
                if len > 1 then
                    coroutine.yield(invert(res))
                end
            end
        end
    else
        local seq_iterator = numeric.integer_iterator({0}, 2)
        local len = math.floor((n - 2)/2)
        while true do
            local seq = seq_iterator()
            if #seq > len then
                break
            end
            local res = {1, 1}
            for j = 1, len  do
                table.insert(res, j + 1, seq[j]) 
                table.insert(res, #res - j, seq[j]) 
            end
            if #seq == len then
                table.insert(res, #res/2 + 1, 0)
                coroutine.yield(res)
                coroutine.yield(invert(res))
                table.remove(res, #res/2 + 1)
                table.insert(res, #res/2 + 1, 1)
                coroutine.yield(res)
                coroutine.yield(invert(res))
            end
        end
    end 
end

function palindrom_iterator(n) 
    return coroutine.wrap(function() return palindrom_generator(n) end)
end


function problem36(n)
    local total = 0
    for j = 1, n do 
        local pals = palindrom_iterator(j)
        while true do
            local pal = pals()
            if not pal then 
                break
            end
            local num10 = numeric.digits2num(pal, 2)
            local digits = numeric.num2digits(num10)
            if is_pal(digits) then
                total = total + num10
                print(table.concat(pal), table.concat(digits))
            end
        end
    end
    print(total)
    return total
end

function bruteforce(n)
    local total = 0
    local pals = numeric.integer_iterator({0}, 2)
    while true do
        local pal = pals()
        if #pal > 20 then
            break
        end
        local num10 = numeric.digits2num(pal, 2)
        local digits = numeric.num2digits(num10)
        if is_pal(digits) and is_pal(pal) then
            total = total + num10
            print(table.concat(pal), table.concat(digits))
        end
    end
    print("total ", total)
    return total
end

problem36(20)
--bruteforce(20)
