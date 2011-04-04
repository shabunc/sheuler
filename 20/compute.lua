#!/usr/bin/env lua


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

function problem_effective(n) 
    local twos = 0
    local fives = 0
    local factor = 1
    for i=2,n do
        local p2,remainder = factorby(i, 2)
        twos = twos + p2
        local p5,remainder = factorby(remainder, 5)
        fives = fives + p5
        factor = factor * remainder
    end
    if fives > twos then
        factor = factor * (5^(fives - twos))
    else
        factor = factor * (2^(twos - fives))
    end
    return problem_func(factor)
end

function problem_bruteforce(n) 
    local fact = 1
    for i=2,n do
        fact = fact*i
    end
    return problem_func(fact)
end

function problem_log(n) 
    
end

num = tonumber(arg[1])
for j=1,num do
    local sum = problem_effective(j)
    print(j, problem_bruteforce(j), sum, fact(j))
end
