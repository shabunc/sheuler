#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function findcubes(max)
    print("fetching cubes")
    local res = {}
    for j = 1, max do
        res[j*j*j] = j
    end 
    print("done")
    return res
end
MAX = 10^7
CUBES = findcubes(MAX)

function is_cube(n)
    return CUBES[n]
end

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

function hypo(n) 
    total = 0
    for j = 1, n do 
        local phi2 = j * totient(j)
        if is_cube(phi2) then
            total = total + j
            print(j, phi2, is_cube(phi2))
        end
    end
    print("TOTAL", total)
    return total
end

hypo(MAX)
