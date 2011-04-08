#!/usr/bin/env lua

function test(a)
    local remainder = (a*a) % (1000 - a)
    return remainder == 0
end

function problem(n)
    for a = 1, n/3 do
        if (a*a) % (n - a) == 0 then
            b = n - a - ((a*a)/(n - a))  
            b = b * 0.5
            assert((a + b + math.sqrt(a*a + b*b)) == n)
            -- поверим на слово авторам проекта, и на первом найденном остановимся
            return a, b, (n - a - b)
        end
    end
end


a, b, c = problem(10000)
print(a,b,c, a*b*c)
