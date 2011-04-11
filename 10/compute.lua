#!/usr/bin/env lua

primes = {[2] = 1}

function is_prime(n)
    if primes[n] then
        return true
    end
    for p in pairs(primes) do
        if n % p == 0 then
            return false
        end
    end
    primes[n] = 1
    return true
end

function problem10(n)
    for j = 3, n, 2 do
        print(j)
        is_prime(j)
    end

    local total = 0
    for p in pairs(primes) do
        total = total + p
    end
    return total
end

print(problem10(2000000))

