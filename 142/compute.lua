#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(a, b, c, maxp)
    local function gen(a, b, c, maxp)
        coroutine.yield(a, b, c, a + b + c)
        for j = -1, 1, 2 do
            for i = -1, 1, 2 do
                local a = a * j
                local b = b *  i
                local na = a + 2 * b + 2 *c
                local nb = 2 * a + b + 2 * c
                local nc = 2 * a + 2 * b + 3 * c
                local p = na + nb + nc
                if na > 0 and nb > 0 and nc > 0 and p <= maxp then
                    gen(na, nb, nc, maxp)
                end
            end
        end
    end
    return coroutine.wrap(function() 
        return gen(a, b, c, maxp)
    end)
end

function good_pair(a, b)
    return (b - a) % 2 == 0 or (b + a) % 2 == 0
end

function scan_all(cs, k) 
    local t = cs[k]
    for j = 1, #t/2, 2 do
        local c = t[j]
        local d = t[j + 1]
        for i = j + 2, #t/2, 2 do
            local a = t[i]
            local b = t[i + 1]
            if cs[b] then
                local x = 2 * (b^2 + a^2)
                local y = 2 * (b^2 - a^2) 
                local z = 2 * (d^2 - c^2)
                --[[
                print(math.sqrt(math.abs(x - y)), math.sqrt(y + x))
                print(math.sqrt(math.abs(x - z)), math.sqrt(z + x))
                ]]
                print(math.sqrt(math.abs(y - z)), math.sqrt(y + z))
                --print(x, y, z)
            end
        end
    end
end

function intersect(ta, tb)
    local res = {}
    for k, v in ipairs(ta) do
       if array.index_of(tb, v) > 0 then
            table.insert(res, v)
       end
    end
    return res
end

function genall(maxp) 
    local a, b, c = 3, 4, 5
    local it = step(a, b, c, maxp)
    local total = 0
    local cs = {}
    while true do 
        local  a, b, c, p = it()
        if not a then
            break
        end
        local t = {a, b, c}
        table.sort(t)
        a, b, c = unpack(t)
        if not cs[c] then
            cs[c] = {}
        end
        table.insert(cs[c], a)
        table.insert(cs[c], b)
        scan_all(cs, c)
    end
end

genall(1500000000)

