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

function is_quick_prime(n) 
    return primes[n] == 1
end

for j=3,30000,2 do
    is_prime(j)
end

function test_conjecture(n)
    for b = 1, math.sqrt(n) do
        prime_candidate = 2*(n - b^2) + 1
        if is_quick_prime(prime_candidate) then
            return true
        end
    end
    return false
end


for j=3,15000 do
    if not is_quick_prime(2*j + 1) then
        if not test_conjecture(j) then
            print("conjecture false for ", j)
        end
    end
end
