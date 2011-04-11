require("array")

numeric = {}

local primes = {

}

local function divisors(n) 
    local res = {}
    local is_prime = true
    for j = 2, math.sqrt(n) do
        local skip = false
        for p in pairs(res) do
            if j % p == 0 then
                skip = true
                res[p] = res[p] + 1
                is_prime = false
                break
            end
        end
        if not skip then
            if n % j == 0 then
                res[j] = 1
                primes[j] = 1
                is_prime = false
            end
        end
    end
    return res, is_prime
end

local function digits2num(t) 
    local res = 0
    for j = 1, #t do
        res = res + 10^(#t - j) * t[j]
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
        local tail = copy(t)
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

local function next_integer(t) 
    local res = array.copy(t)
    local i = #res - 1
    if res[#res] ~= 9 then
        res[#res] = res[#res] + 1
    else
        res[#res] = 0
        while res[i] == 9 do
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

local function combinations_iterator(k,t) 
    return coroutine.wrap(function() return combinations(k, t, k) end)
end

numeric.divisors = divisors
numeric.digits2num = digits2num 
numeric.num2digits = num2digits
numeric.combinations_iterator = combinations_iterator
numeric.next_integer = next_integer
return numeric
