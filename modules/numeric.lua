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
    local len = math.floor(math.log10(n+1))
    for j = len - 1, 0, -1  do
        local digit =  math.floor(n/(10^j))
        table.insert(res, digit)
        n = n - digit * 10^j
    end
    return res
end

numeric.divisors = divisors
numeric.digits2num = digits2num 
numeric.num2digits = num2digits
return numeric
