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
    while iterator > 9 do
        local degree = 10 ^ (math.ceil(math.log10(iterator)-1))
        local digit = math.floor(iterator/degree)
        table.insert(res, digit)
        iterator = iterator - degree * digit
    end
    table.insert(res,iterator)
    return res
end

num = 10000
print(num)
res = getdigits(num)
for i,v in pairs(res) do print(i,v) end

