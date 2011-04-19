require("array")


numeric = {}

local primes = {

}

local function is_prime(n) 
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

local function mcombinations_generator(ks, t, k, nk, inner)
    if nk > #ks then
        return {{{}}}
    end
    local res = {}
    local cks  = array.copy(ks)
    cks[nk] = cks[nk] - 1
    for j = 1, #t do 
        local tail = array.copy(t)
        local head = table.remove(tail, j)
        local edge = false
        if cks[nk] == 1 then
            edge = true    
        end
        if cks[nk] == 0 then
            nk = nk + 1
        end
        local mcombs = mcombinations_generator(cks, tail, k, nk, true)
        for j, comb in ipairs(mcombs[#mcombs]) do
            table.insert(comb, 1, head)
            table.insert(res, comb)
            if not inner then
                coroutine.yield(comb)
            end
        end
    end 
    if inner then
        return res 
    end
end

local function mcombinations_iterator(ks, t)
    return coroutine.wrap(function() 
        return mcombinations_generator(ks, t, ks[1], 1)
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
            return {{{t[from], n / t[from]}}}
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

numeric.is_prime = is_prime
numeric.digits2num = digits2num 
numeric.num2digits = num2digits
numeric.combinations_iterator = combinations_iterator
numeric.mcombinations_iterator = mcombinations_iterator
numeric.next_integer = next_integer
numeric.integer_iterator = integer_iterator
numeric.partitions_iterator =  partitions_iterator
return numeric
