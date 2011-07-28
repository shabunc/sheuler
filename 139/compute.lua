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

function genall(maxp) 
    local a, b, c = 3, 4, 5
    local uniqs = {}
    local it = step(a, b, c, maxp)
    local total = 0
    while true do 
        local  a, b, c, p = it()
        if not a then
            break
        end
        local t = {a, b, c}
        table.sort(t)
        a, b, c = unpack(t)
        local test = c % (b - a) == 0
        if test then
            total = total + math.floor(maxp / p)
            print (a, b, c, test)
        end
    end
    print("TOTAL", total)
end

genall(100000000)

