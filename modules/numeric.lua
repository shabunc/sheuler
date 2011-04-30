require("array")


numeric = {}

local primes = {

}

local function is_prime(n) 
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
    return true
end

local function get_degree(n, p) 
    local deg = 0
    while n % p == 0 do
        deg = deg + 1
        n = n / p
    end
    return n, deg
end

local function divisors(n) 
    local res = {}
    local deg
    n, deg = get_degree(n, 2) 
    table.insert(res, {2, deg})
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

local function combinations(k, t, k_caller) 
    if k == 0 then
        return {{}}
    end
    local res = {}
    for i, head in ipairs(t) do
        local tail = array.copy(t)
        table.remove(tail, i)
        local combs = combinations(k - 1, tail, k)
        for j, comb in ipairs(combs) do
            table.insert(comb, 1, head)
            table.insert(res, comb)
            if k == k_caller then
                coroutine.yield(comb)
            end
        end
    end
    if k ~= k_caller then
        return res
    end
end

local function hcombinations_generator(k, t, h) 
    if k == 0 then
        return {{}}
    end
    local res = {}
    for i, head in ipairs(t) do
        local ch = array.copy(h)
        local tail = array.copy(t)
        local combs = hcombinations_generator(k - 1, tail, ch)
        for j, comb in ipairs(combs) do
            table.insert(comb, 1, head)
            table.insert(res, comb)
            if #h == #t then
                coroutine.yield(comb, ch)
            end
        end
    end
    if k ~= k_caller then
        return res
    end
end

local function hcombinations_iterator(ks, t)
    return coroutine.wrap(function() 
        return hcombinations_generator(ks, t, t)
    end)
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

local function combinations_iterator(k,t) 
    return coroutine.wrap(function() return combinations(k, t, k) end)
end

local serialize_partition = function(t)
    local s = ""
    for i, v in ipairs(t) do
        s = s  .. v[1] .. "*" .. v[2] .. " "
    end
    return s
end

local function partitions_generator(n, t, from, inner) 
    local rem = n / t[from]
    local res = {}
    if from == #t then
        if n % t[from] == 0 then
            return {{{ n / t[from], t[from]}}}
        else
            return false
        end 
    end
    for j = 0, math.floor(rem) do
        local head = {j, t[from]}
        local ps = partitions_generator(n - t[from] * j, t, from + 1, true)
        if ps then 
            for _, p in ipairs(ps) do
                table.insert(p, 1, head)
                table.insert(res, p)
                if not inner then
                    setmetatable(p, { __tostring = serialize_partition })
                    coroutine.yield(p)
                end
            end
        end
    end
    if inner then
        return res
    end
end

local function partitions_iterator(n, t)
    return coroutine.wrap(function() return partitions_generator(n, t, 1) end)
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

numeric.is_prime = is_prime
numeric.digits2num = digits2num 
numeric.divisors = divisors
numeric.num2digits = num2digits
numeric.combinations_iterator = combinations_iterator
numeric.hcombinations_iterator = hcombinations_iterator
numeric.next_integer = next_integer
numeric.integer_iterator = integer_iterator
numeric.partitions_iterator =  partitions_iterator
numeric.factorial = factorial
numeric.sign = sign
return numeric
