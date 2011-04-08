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


function shift(n)
    local len = math.floor(math.log10(n + 1))
    local deg = 10^len
    local biggest = math.floor(n / deg) 
    return (n - deg * math.floor(n / deg)) * 10 + biggest, biggest
end

function shift_iterator(n) 
    return coroutine.wrap(function() 
        local turtle, hair = n, n
        while true do
            local first_digit
            turtle, first_digit  = shift(turtle)
            hair = shift(shift(hair))
            coroutine.yield(turtle, first_digit)
            if turtle == hair then
                break
            end
        end
    end)
end

function prime_is_cycle(p) 
    local get_next = shift_iterator(p)
    local count = 0
    while true do
        local n_shifted, first_digit = get_next()
        if not n_shifted then
            break
        end
        if first_digit == p then
            return 1
        end
        if first_digit % 2 == 0 or first_digit == 5 then
            return 0
        end
        if not primes.primes[n_shifted] then
            return 0
        end
        count = count + 1
    end
    return count
end

function problem(n)
    co = coroutine.wrap(allprimes)
    local total = 1 --two already is counted
    while true do
       local p, is_prime  = co()
       if is_prime then
           if (p > n) then
                break
           end
           total = total + prime_is_cycle(p)
       end
    end
    print(total)
end

problem(100)
