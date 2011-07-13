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

function remarkable_generator(n, rems, from, max)
    if n == 1 then
        print(table.concat(rems, " "))
    end
    if n == 0 then
        coroutine.yield(rems)
    else
        for j = from, max do
            local p = numeric.prime(j)
            --print("searching from ", p)
            local lrems = array(rems)
            if remarkable_to(p, lrems) then
                table.insert(lrems, p)
                remarkable_generator(n - 1, lrems, j + 1, max)
            end
        end
    end
end

function remarkable_iterator(n, max) 
    return coroutine.wrap(function() 
        return remarkable_generator(n, {}, 2, max)
    end)
end


function problem60(n, max)
    local it = remarkable_iterator(n, max)
    while true do
        local seq = it()
        if not seq then
            break
        end
        local sum = array.reduce(seq, function(a, b) return a + b end)
        print(string.format("!!! %s => %i" ,table.concat(seq, " "), sum))
        return
    end
end

problem60(5, 2000)
