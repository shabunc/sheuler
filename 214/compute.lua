#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function divisors(n, divs, from) 
    divs = divs or {}
    from = from or 2
    --print(n, table.concat(divs," "), from)
    if from == n then
        array.insert_sorted(divs, from)
        return divs
    end
    if n % from == 0 then
        array.insert_sorted(divs, from)
        return divisors(n / from, divs, from)
    else
        from = from == 2 and 3 or (from + 2)
        return divisors(n, divs, from)
    end
end

function totient(n, divs) 
    if n == 1 then
        return 1
    end
    divs = divs or divisors(n)
    local res = n 
    for _, p in ipairs(divs) do
        res = res/p
        res = res * (p - 1)
    end 
    return res, divs
end

function chain(n)
    if n == 1 then
        return 1
    end
    local phi = totient(n)
    return chain(phi) + 1, phi
end

function prolem214(max, len) 
    local total = 0
    for n = 1, max do
        local l, phi = chain(n)
        if l == len and phi == (n - 1) then
            print(n)
            total = total + n
        end
    end
    return total
end

assert(prolem214(20, 4) == 12)
prolem214(4 * 10^7, 25)
