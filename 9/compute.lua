#!/usr/bin/env lua

function test(a)
    local remainder = (a*a) % (1000 - a)
    return remainder == 0
end

function problem()
    for a = 1, 333 do
        if test(a) then
            b = 1000 - a - ((a*a)/(1000 - a))  
            b = b * 0.5
            assert((a + b + math.sqrt(a*a + b*b)) == 1000)
            -- поверим на слово авторам проекта, и на первом найденном остановимся
            return a, b, (1000 - a - b)
        end
    end
end


a, b, c = problem()
print(a,b,c, a*b*c)
