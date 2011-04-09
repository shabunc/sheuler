#!/usr/bin/env lua

local primes = {

}

function divisors(n) 
    local res = {}
    for j = 2, math.sqrt(n) do
        local skip = false
        for p in pairs(primes) do
            if j % p == 0 then
                skip = true
                res[p] = res[p] + 1
                break
            end
        end
        if not skip then
            if n % j == 0 then
                res[j] = 1
                primes[j] = 1
            end
        end
    end
    return res
end

d = divisors(600851475143)
for k,v in pairs(d) do
    print(k,v)
end
