#!/usr/bin/env lua

function factsum(n) 
    local fact = 1
    for i=1,n do
        local prevfact = fact
        fact = fact*i
        print(i, total(getdigits(fact)), total(getdigits(problem_equivalent(fact))))
        --assert(i == fact/prevfact)
    end
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
    degree = 0
    iterator = n
    while iterator % p == 0 do
        degree = degree + 1
        iterator = iterator / p
    end
    return degree , iterator
end

function problem_equivalent(n) 
    local fives, remainder = factorby(n, 5)
    local twos, remainder = factorby(remainder, 2)
    if fives > twos then
        remainder = (5^(fives - twos)) * remainder
    else
        remainder = (2^(twos - fives)) * remainder
    end
    return remainder, twos, fives
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
