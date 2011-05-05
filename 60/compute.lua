#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function both_remarkable(a, b)
    local pa = numeric.digits(a)
    local pb = numeric.digits(b)
    for j = 1, #pb do
        table.insert(pa, pb[j])
    end
    local na = numeric.number(pa)
    return numeric.is_prime(na)
end

function all_remarkable(primes)
    if #primes == 1 then
        return 1
    end 
    local it = numeric.combinations_iterator(2, primes)
    while true do
        local seq = it()
        if not seq then
            break
        end
        if not both_remarkable(seq[1], seq[2]) then
            return false
        end
    end
    return true
end

assert(all_remarkable({3, 7, 109, 673}) == true)
