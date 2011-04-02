#!/usr/bin/env lua

function factsum(n) 
    local fact_ = 1
    local fact = 1
    local twos, fives = 0
    local factors = {}
    local factors_equivalent = {}
    for i=2,n do
        fact = fact*i
        fact_ = problem_equivalent(fact_) * problem_equivalent(i)
        fact_ = problem_equivalent(fact_)
        print(i, problem_func(fact_), problem_func(fact))
    end
    return factors
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

function reduce(t, func)
    local res = t[1]
    for i=2,#t do
        res = func(res, t[i])
    end
    return res
end

function total(t)
    return reduce(t, function(a,b) return a+b end)
end

function factorby(n, p) 
    local degree = 0
    local iterator = n
    while iterator % p == 0 do
        degree = degree + 1
        iterator = iterator / p
    end
    return degree , iterator
end

function problem_equivalent(n) 
    local fives, remainder = factorby(n, 5)
    local twos, remainder = factorby(remainder, 2)
    local degree
    if fives > twos then
        degree = fives - twos
        remainder = (5^degree) * remainder
    else
        degree = twos - fives
        remainder = (2^degree) * remainder
    end
    return remainder, degree
end

function problem_func(n) 
    return total(getdigits(n))
end

function fact(n) 
    if (n==1) then 
        return 1
    else
        return n * fact(n-1)
    end
end

num = tonumber(arg[1])
factsum(num)
