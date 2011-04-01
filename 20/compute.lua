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

factsum(50)
