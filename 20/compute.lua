#!/usr/bin/env lua

function factsum(n) 
    local fact = 1
    for i=1,n do
        local prevfact = fact
        fact = fact*i
        print(i, total(getdigits(fact)))
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

function total(t) 
    local total = 0
    for i=1,#t do
        total = total + t[i]
    end
    return total
end

num = tonumber(arg[1])
factsum(num)
