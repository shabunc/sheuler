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

function stackstep(maxp)
    local stack = {{3, 4, 5}}
    while #stack > 0 do
        local a, b, c = unpack(table.remove(stack))
        if a > 0 and b > 0 and c > 0 and (a + b + c) < maxp then
            print(a, b, c)
            for _, la in ipairs{-a, a} do
                for _, lb in ipairs{-b, b} do
                    local na = la + 2 * lb + 2 * c
                    local nb = 2 * la + lb + 2 * c
                    local nc = 2 * la + 2 * lb + 3 * c
                    table.insert(stack, {na, nb, nc})
                end
            end
        end
    end
end


stackstep(1000)
