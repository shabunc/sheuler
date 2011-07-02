#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function remarkable_pair(a, b)
    local testa = numeric.is_prime(numeric.concat(a, b))
    local testb = numeric.is_prime(numeric.concat(b, a))
    return testa and testb
end

assert(remarkable_pair(3, 109))
assert(not remarkable_pair(2, 109))


function remarkable_to(p, tail) 
    for j = 1, #tail do
        if not remarkable_pair(p, tail[j]) then
            return false
        end
    end
    return true
end

function remarkable_generator(n, rems)
    if n == 0 then
        coroutine.yield(rems)
    else
        for j = 1, math.huge do
            local p = numeric.prime(j)
            if remarkable_to(p, rems) then
                local tail = array(rems)
                table.insert(tail, 1, p)
                remarkable_generator(n - 1, tail)
            end
        end
    end
end

function remarkable_iterator(n)
    return coroutine.wrap(function() 
        return remarkable_generator(n, {})
    end)
end

function problem60(n)
    local it = remarkable_iterator(n)
    while true do
        local seq = it()
        if not seq then
            break 
        end 
        print(table.concat(seq))
    end
end

problem60(2)
