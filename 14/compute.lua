#!/usr/bin/env lua

COLLATZ = {[1] = 1}

function collatz(n) 
    if n % 2 == 0 then
        return n/2
    end
    return 3 * n + 1
end

function chain(n) 
    local res = {n}
    local iterator = n
    while true do
       iterator = collatz(iterator) 
       table.insert(res, iterator)
       if iterator == 1  then 
            break
       end  
    end
    return res
end

function brute(n) 
    local largest = {}
    for j = 1, n do
        local seq = chain(j) 
        for j = #seq, 1, -1 do
            COLLATZ[seq[j]] = #seq - j + 1 
        end
        print(table.concas(COLLATZ," "))
        if #seq > #largest then
            largest = seq
        end
    end
    return largest
end

function problem14()
    local largest = 0
    for j = 1, n do
        local len = 1
        local iterator = j
        while true do
           iterator = collatz(iterator)
           if COLLATZ
           len =  len + 1 
           if (iterator == 1) then
                break
           end
        end
    end
    return largest
end

print(table.concat(brute(999999), " "))
