#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")
require("array")

primes = (function() 
    local max = 3
    local primeslookup = {2, 3}

    local function is_prime(n) 
        local test = true
        for j = 1, math.sqrt(n) do
            if n % primeslookup[j] == 0 then
                test = false
                break
            end
        end
        return test
    end

    return function(n) 
       if n <= #primeslookup then
            return primeslookup[n]
       end
       m = primeslookup[#primeslookup] + 2
       while #primeslookup ~= n do
            if is_prime(m) then
                table.insert(primeslookup, m)
            end
            m = m + 2
       end
       return primeslookup[n]
    end
end)()

function divisors(n) 
    local k = 1
    local divs = {}
    while primes(k) <= n/2 do 
        if n % primes(k) == 0 then
            table.insert(divs, primes(k))
        end
        k = k + 1
    end
    if #divs == 0 then
        table.insert(divs, n)
    end
    return divs
end

function alldivisors(n)
    local all = {}
    local divs = divisors(n)
    local m = n
    for _, div in ipairs(divs) do
        local deg = 0
        while m % div == 0 do
            m = m / div
            deg = deg + 1
        end
        table.insert(all, {div, deg})
    end
    if #all == 0 then
        table.insert(all, {n, 1})
    end
    return all
end

function totient(n, divs)
   if n == 1  then
        return 1
   end 
   local divs = divs or divisors(n) 
   res = n 
   for _, p in ipairs(divs) do
        res = res/p
        res = res * (p - 1)
   end 
   return res 
end

assert(totient(87109) == 79180)
assert(totient(2310) == 480)
assert(totient(30030) == 5760)

function are_permutations(a, b)
    local da = array(numeric.digits(a))
    local db = array(numeric.digits(b))
    table.sort(da)
    table.sort(db)
    return da == db
end

function firstprime(n)
    local i = 1
    while primes(i) <= n do
        i = i + 1
    end    
    return i - 1, primes(i - 1)
end

function problem70(n)
    local min = math.huge
    local minnum, minphi
    local max = firstprime(n)
    print(max)
    for j = 1, max do
        local p1 = primes(j)
        for i = max, j, -1 do
            local p2 = primes(i)
            local num = p1 * p2
            if num < n then
                local phi = totient(num) 
                if are_permutations(num, phi) then
                    if min > num/phi then
                        min = num/phi
                        minnum = num
                        minphi = phi
                        print(minnum, minphi, p1, p2, min)
                    end
                    break
                end
            end
        end
    end
end

function problem702(n)
    local min = math.huge
    local minnum, minphi
    for j = 1, n do
        local p1 = primes(j)
        if p1 > n then
            break
        end
        local p2
        for i = j, n do
            p2 = primes(i)
            if p2 > n or p1 * p2 > n then
                break
            end
            local num = p1 * p2
            local phi = totient(num) 
            if are_permutations(num, phi) then
                if min > num/phi then
                    min = num/phi
                    minnum = num
                    minphi = phi
                    print(minnum, minphi, p1, p2, min)
                end
            end
        end
    end
end

function problem703(n)
    local min = math.huge
    for k = n, 1, -1 do 
        local divs = divisors(k)
        if #divs == 2 then
            local phi = totient(k, divs)
            if are_permutations(k, phi) then
                if min > k/phi then
                    min = k/phi
                    print(k, phi, divs[1], divs[2], k/phi)
                end
            end
        end
    end
end

function problem70(n)
    local max = firstprime(math.sqrt(n))
    print("start from", primes(max))
    local min = math.huge
    for j = max, n do
        for i = j, 1, -1 do
            local p1 = primes(j)
            local p2 = primes(i)
            local num = p1 * p2
            if num <= n then
                local phi = totient(num, {p1, p2})
                if are_permutations(num, phi) then
                    if min > num/phi then
                        min = num/phi
                        print(num, phi, p1, p2, num/phi, are_permutations(num, phi))
                    end 
                end
            end
        end
    end
end

problem70(10^7)
