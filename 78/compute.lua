#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("bignum")

local CACHE = {}

function pile_count(n, inner) 
    if n == 0 then
        return bignum{1}
    end
    local res = bignum{0}
    for j = n, 1, -1 do
        local m = math.min(n - j, j)
        local rec = CACHE[m] or pile_count(m, true)
        CACHE[m] = rec
        res = res:add(rec)
    end
    return res
end

function has_n_zeros(t, n)
    for j = #t, #t - n + 1, -1 do
        if t[j] ~= 0 then
            return false
        end
    end
    return true
end

function problem78(n)
    local j = 1
    while true do
        local res = pile_count(j)
        print(res)
        if has_n_zeros(res, n)  then
            print("FOUND!", j, res)
            break
        end
        j = j + 1
    end
end

problem78(6)
