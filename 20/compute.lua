#!/usr/bin/env lua

function factsum(n) 
    local fact = 1
    for i=1,n do
        local prevfact = fact
        fact = fact*i
        print(i, fact/prevfact, fact)
        assert(i == fact/prevfact)
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

num = tonumber(arg[1])
print(num)
res = getdigits(num)
print(table.concat(res," "))
