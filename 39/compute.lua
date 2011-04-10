#!/usr/bin/env lua

function find_isoperimetric(p) 
    local total = 0
    for j = 1, p/3 do
        local a,b,c
        if (j*j) % (p - j) == 0 then
            a = j
            b = p - j - (j*j)/(p-j)
            b = b * 0.5
            c = p - a - b
            if b >= a then
                total = total + 1
            end
        end
    end
    return total
end

function problem39(n)
    local max = 0
    for j = 2, n, 2 do
        local triples =  find_isoperimetric(j)
        if triples > max then
            max = triples
            print("max", max, j)
        end
    end
end

problem39(1000)
