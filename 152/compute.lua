#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function generator(n, t, from, res)
    if n == 0 then
        coroutine.yield(res)
        return
    end
    for j = from, #t do
        local lres = array(res)
        table.insert(lres, t[j])
        generator(n - 1, t, j + 1, lres) 
    end
end

function iterator(n, t) 
    return coroutine.wrap(function() 
        return generator(n, t, 1, {}) 
    end)
end

function problem152(t)
    for n = 2, #t do
        local it = iterator(n, t)
        while true do
            local seq = it()
            if not seq then
                break
            end
            print(table.concat(seq," "))
        end
    end
end

problem152({2,3,4,5,7,12,15,20,28,35})
