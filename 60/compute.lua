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

function contains_remarkable(seq, len)
    local it = numeric.combinations_iterator(len, seq)
    while true do
        local seq = it()
        if not seq then 
            break 
        end
        if all_remarkable(seq) then
            return seq
        end
    end
    return false
end

function problem60(len)
    if len == 2 then
        return {3, 7}
    end
    local primes = problem60(len - 1)
    local n = primes[#primes] + 2
    while true do
        if numeric.is_prime(n) then
            local seq = contains_remarkable(primes, len - 1)
            if seq then
                table.insert(seq, n)
                print(table.concat(seq," "))
                if all_remarkable(seq) then
                    print("SEQ", table.concat(seq, " "), "=>", array.reduce(seq, function(a, b) return a + b end))
                    return seq
                end
            end
            table.insert(primes, n)
        end
        n = n + 2
    end
end

assert(all_remarkable({3, 7, 109, 673}) == true)
assert(contains_remarkable({3, 7, 17, 109, 673}, 4) ~= false)

problem60(5)



