#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function bin_palindroms(n) 
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
        end
    end
    return res
end

local p = bin_palindroms(21) 
for i, v in pairs(p) do
    print(table.concat(v))
end
