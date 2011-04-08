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

function getdigits(num)
    local iterator = num
    local res = {}
    for i = math.ceil(math.log10(num+1)) - 1,0,-1 do
        local digit =  math.floor(iterator/(10^i))
        table.insert(res, digit)
        iterator = iterator - digit * 10^i
    end
    return res
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
       local num, is_prime  = co()
       if is_prime then
            if (num < n) then
                local digits = getdigits(num)
                table.sort(digits)
                print(table.concat(digits, " "))
            else
                break
            end
       end
    end
end

problem(100)
