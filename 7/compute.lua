#!/usr/bin/env lua

local primes = {
 ["primes"] = {[2] = 1},
 ["card"] = 1
}

function is_prime(n) 
    local sqr_n = math.sqrt(n)
    for p, v in pairs(primes.primes) do
        if (n % p == 0) then
            return false
        end
    end
    primes.primes[n] = 1
    primes.card = primes.card + 1
    return true
end

function problem(n)
    local num = 3
    while true do
        is_prime(num)
        if primes.card == n then
            return num, primes.card
        end
        num = num + 2
    end
end

num, card = problem(10001)
print(num, card)
