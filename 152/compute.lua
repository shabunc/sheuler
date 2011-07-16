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
    for j = from, 1, -1 do
        local lres = array(res)
        table.insert(lres, t[j])
        generator(n - 1, t, j - 1, lres) 
    end
end

function iterator(n, t) 
    return coroutine.wrap(function() 
        return generator(n, t, #t, {}) 
    end)
end

function squares(t, skip_index) 
    local res = bignum{1}
    for j = 1, #t do 
        if j ~= skip_index then
            local n = bignum(numeric.digits(t[j]))  
            res = res:mul(n:mul(n))
        end
    end
    return res
end

function sumall(t)
    local sum = bignum{0}
    for skip_index = 1, #t do
        sum = sum:add(squares(t, skip_index))
    end
    local total = squares(t, #t + 1)
    return sum:mul(bignum{2}) == total
end

assert(sumall{2,3,4,5,7,12,15,20,28,35} == true)
assert(sumall{2,3,4,6,7,9,10,20,28,35,36,45} == true)

function sumit(t)
    local res = array.reduce(t, function(a, b) return a + 1/ (b * b) end)
    local maybe_good = string.format("%.4f", res) == "0.5000"
    return res, maybe_good
end


function problem152(t)
    for n = 2, #t do
        local it = iterator(n, t)
        while true do
            local seq = it()
            if not seq then
                break
            end
            print(table.concat(seq," "), sumit(seq))
        end
    end
end


problem152(array.range(2, 45))
