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

function allprimes()
    local num = 3
    while true do
        coroutine.yield(num, is_prime(num))
        num = num + 2
    end
end

function problem(n)
    co = coroutine.wrap(allprimes)
    while true do
       local p, is_prime  = co()
       if is_prime then
           if (p > n) then
                break
           end
       end
    end
end

function shift(n)
    local len = math.floor(math.log10(n + 1))
    local deg = 10^len
    local biggest = math.floor(n / deg) 
    return (n - deg * math.floor(n / deg)) * 10 + biggest
end

function shift_iterator(n) 
    return coroutine.wrap(function() 
        local turtle, hair = n, n
        local count = 0
        while true do
            count = count + 1
            turtle = shift(turtle)
            hair = shift(shift(hair))
            coroutine.yield(turtle)
            if turtle == hair then
                break
            end
        end
    end)
end


local next_shift  = shift_iterator(123123)
while true do
    local n = next_shift()
    print(n)
    if not n then
        break
    end
end
