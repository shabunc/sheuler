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

function remarkable_generator(n, rems, from)
    if n == 0 then
        coroutine.yield(rems)
    else
        for j = from, 20000 do
            local p = numeric.prime(j)
            local lrems = array(rems)
            if remarkable_to(p, lrems) then
                table.insert(lrems, p)
                remarkable_generator(n - 1, lrems, j + 1)
            end
        end
    end
end

function remarkable_iterator(n) 
    return coroutine.wrap(function() 
        return remarkable_generator(n, {}, 2)
    end)
end

function gen_for_prime(n, m, rems) 
    if n == 0 then
        coroutine.yield(rems)
    end 
    for j = m, 1, -1 do
        local p = numeric.prime(j) 
        if remarkable_to(p, rems) then
           local lrems = array(rems) 
           table.insert(lrems, p)
           gen_for_prime(n - 1, j - 1, lrems)
        end
    end
end

function iter_for_prime(n, m) 
    return coroutine.wrap(function() 
        return gen_for_prime(n, m, {})  
    end)
end


function problem60(n)
    for j = 122, math.huge do
        print(j)
        local it = iter_for_prime(n, j)
        while true do
            local seq = it()
            if not seq then
                break
            end
            print(table.concat(seq, " "), array.reduce(seq, function(a, b) return a + b end))
            return
        end
    end
end

problem60(5)

