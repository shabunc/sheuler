#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function unorthodox(a, b) 
    if a == b then
        return false
    end
    local da = numeric.digits(a)
    local db = numeric.digits(b)
    local simplified = false
    for i = 1, #da do
        for j = 1, #db do
            if i ~= j and da[i] == db[j] then
                table.remove(da, i)
                table.remove(db, j)
                i = i - 1
                j = j - 1
                simplified = true
            end
        end
    end
    if simplified then
        local sa = numeric.number(da)
        local sb = numeric.number(db)
        if (a / b) == (sa / sb) then
            return sa, sb
        end
    end
    return false
end


function problem33()
    local nominators = {}
    local denominators = {}
    for a = 10, 99 do
        for b = a, 99 do
            local sa, sb = unorthodox(a, b)
            if sb then
                print(a, b, "=>", sa, sb)
                table.insert(nominators, sa)
                table.insert(denominators, sb)
            end
        end
    end
    print(array.reduce(nominators, function(a, b) return a*b end, 1))
    return array.reduce(denominators, function(a, b) return a*b end, 1)
end

print(problem33())
