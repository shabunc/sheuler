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

function scan_all(cs, c) 
    for j = 1, #cs[c] do
        for i = j + 1, #cs[c] do
            local ta, tb = 2 * cs[c][j][1], 2 * cs[c][i][2]
            local tc, td = 2 * cs[c][j][1], 2 * cs[c][i][2]
            local x = (ta^2 + tb^2) / 2
            local z = (tb^2 - ta^2) / 2
            local y = (td^2 - tc^2) / 2
            local res = x + y + z
            print(x, y, z, "=>", res)
            --print(math.sqrt(x + y), math.sqrt(x - y), math.sqrt(x - z), math.sqrt(x + z), math.sqrt(y + z), math.sqrt(y - z), "=> ", res)
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
        a = 2 * a
        b = 2 * b
        c = 2 * c
        if not cs[c] then
            cs[c] = {}
        end
        table.insert(cs[c], a, b)
        local inter = intersect(cs[c], cs[b] or {})
        print(#inter)
    end
end

genall(60000000)

