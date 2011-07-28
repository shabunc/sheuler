require("array")
--чтобы стары код сразу весь не поломался
require("iterator")

numeric = {}

local primes = {

}

local function is_prime(n) 
    if primes[n] then
        return true
    end
    if n == 1 then
        return false
    end
    if n == 2 then
        return true
    end
    if n % 2 == 0 then
        return false
    end
    local lim = math.sqrt(n)
    local sieve = {}
    for j = 3, lim, 2 do
        if not sieve[j] then
            if n % j == 0 then
                return false
            else
               for k = 1, math.floor(lim / j) do
                    sieve[j*k] = 1
               end
            end
        end
    end
    primes[n] = 1
    return true
end

local prime = (function() 
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

local prime_till = function(lim) 
    local n = 1
    while prime(n) < lim do
        print(n)
        n = n + 1
    end
    return prime(n - 1), (n - 1)
end

local function get_degree(n, p) 
    local deg = 0
    while n % p == 0 do
        deg = deg + 1
        n = n / p
    end
    return n, deg
end

local function divisors_tostring(res)
    local s = {}
    for j = 1, #res do
        table.insert(s, res[j][1].."^"..res[j][2])
    end
    return table.concat(s," * ")
end

local CACHE_DIVISORS = {}

local function divisors(n) 
    local k = 1
    local divs = {}
    while numeric.prime(k) <= n/2 do 
        if n % numeric.prime(k) == 0 then
            table.insert(divs, numeric.prime(k))
        end
        k = k + 1
    end
    if #divs == 0 then
        table.insert(divs, n)
    end
    return divs
end

local function alldivisors(n) 
    if n == 1 then
        return setmetatable({{1, 1}}, {
                 ["__tostring"] = divisors_tostring
               })
    end
    if CACHE_DIVISORS[n] then
        return CACHE_DIVISORS[n]
    end
    local res = {}
    local deg
    n, deg = get_degree(n, 2) 
    if deg ~= 0 then 
        table.insert(res, {2, deg})
    end
    local p = 3
    while n ~= 1 do
        if is_prime(p) then
            n, deg = get_degree(n, p) 
            if deg ~= 0 then
                table.insert(res, {p, deg})
            end
        end
        p = p + 2
    end
    setmetatable(res, {
        ["__tostring"] = divisors_tostring
    })
    CACHE_DIVISORS[n] = res
    return res
end 

local function HCF(a, b) 
    if b > a then
        a, b = b, a
    end
    if b == 0 then
        return a
    end
    return HCF(b, a % b)
end


local function are_rel_primes(a, b) 
    return HCF(a, b) == 1
end

local function totient(n, divs)
    if n == 1 then
        return 1
    end
   local divs = divs or numeric.divisors(n) 
   local res = n 
   for _, p in ipairs(divs) do
        res = res/p
        res = res * (p - 1)
   end 
   return res, divs
end

local function propers(n)
    local res = {1, n}
    for j = 2, math.sqrt(n) do
        if n % j == 0 then
            table.insert(res, j)
            if n/j ~= j then
                table.insert(res, n/j)
            end
        end
    end
    return res
end

local function digits2num(t, base) 
    base = base or 10
    local res = 0
    for j = 1, #t do
        res = res + base^(#t - j) * t[j]
    end
    return res
end

local function num2digits(n)
    local res = {}
    local len = math.floor(math.log10(n))
    for j = len, 0, -1  do
        local digit =  math.floor(n/(10^j))
        table.insert(res, digit)
        n = n - digit * 10^j
    end
    return res
end

local function next_integer(t, base) 
    base = base or 10
    local max_digit = base - 1
    local res = array.copy(t)
    coroutine.yield(res)
    local i = #res - 1
    if res[#res] ~= max_digit then
        res[#res] = res[#res] + 1
    else
        res[#res] = 0
        while res[i] == max_digit do
            res[i] = 0
            i = i - 1
        end
        if i == 0 then
            table.insert(res, 1, 1)
        else
            res[i] = res[i] + 1
        end
    end
    return res
end

local function integer_iterator(t, base)
    return coroutine.wrap(function() 
        local iterator = t
        while true do
             iterator = next_integer(iterator, base)
        end
    end)
end

local function sum_generator(n, parts, inner) 
    if parts == 1 then
        return {{n}}
    end
    local res = {}
    for head = 1, n - parts do
        local tail = sum_generator(n - head, parts - 1, true)
        for _, v in ipairs(tail) do
            table.insert(v, 1, head)
            table.insert(res, v)
            if not inner then
                coroutine.yield(v)
            end
        end
    end
    if inner then
        return res
    end
end

local sum_iterator = function(n, parts) 
    return coroutine.wrap(function() return sum_generator(n, parts) end)
end

local FACT_CACHE = {[0] = 1}

local function factorial(n)
    if FACT_CACHE[n] then
        return FACT_CACHE[n]
    else
        local res = n * factorial(n - 1)
        FACT_CACHE[n] = res
        return res
    end
end

local function sign(n)
    if n > 0 then
        return 1
    elseif n == 0 then
        return 0
    else
        return -1
    end
end

local function concat(a, b)
    local da = numeric.digits(a)
    local db = numeric.digits(b)
    local res = {}
    for j = 1, #da do
        table.insert(res, da[j])
    end
    for j = 1, #db do
        table.insert(res, db[j])
    end
    return numeric.number(res)
end

local function is_square(n)
    local sq = math.sqrt(n)
    return math.floor(sq) == math.ceil(sq)
end

numeric.is_prime = is_prime
numeric.is_square = is_square
numeric.are_rel_primes = are_rel_primes
numeric.HCF = HCF
numeric.concat = concat
numeric.digits2num = digits2num 
numeric.number = digits2num 
numeric.alldivisors = alldivisors
numeric.divisors = divisors
numeric.propers = propers
numeric.prime = prime
numeric.prime_till = prime_till
numeric.num2digits = num2digits
numeric.digits = num2digits
numeric.combinations_iterator = iterator.combinations
numeric.next_integer = next_integer
numeric.integer_iterator = integer_iterator
numeric.partitions_iterator = iterator.partitions
numeric.sum_iterator =  sum_iterator
numeric.totient = totient
numeric.factorial = factorial
numeric.sign = sign
return numeric
