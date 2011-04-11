#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function bin_palindroms(n, n_caller) 
    if n == 1 then
        return {{0}, {1}}
    end
    local res = {}
    for j = 1, n-1 do
        pals = bin_palindroms(n - j)
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

local pals = bin_pal_iterator(3)
while true do
    p = pals()
    if not p then
        break
    end
    print(table.concat(p), numeric.digits2num(p,2))
end
