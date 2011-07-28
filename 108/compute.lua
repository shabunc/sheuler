#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function fraction(a, b)
    local h = numeric.HCF(a, b)
    return a / h, b / h
end

function add(a, b, c, d)
    return fraction(a * d  + b * c, b * d)
end

function problem108(max)
    local res = {}
    local lmax = -1
    for a = 1, math.huge do
        local divs = numeric.propers(a)
        for d = 2, #divs do
            --local n = (a / divs[d]) * (divs[d] - 1)
            local n = a - (a / divs[d]) 
            --print(n, a, divs[d])
            if not res[n] then
                res[n] = 0
            end
            res[n] = res[n] + 1
            if res[n] > lmax then
                lmax = res[n]
                io.write(lmax, " ")
                io.flush()
            end
            if res[n] > max then
                print(string.format("\nMAX=%i N=%i", res[n], n))
                local divs = numeric.alldivisors(n)
                print(divs)
                --print(table.concat(divs, " "))
                return
            end
        end
    end
end

function altsearch(n) 
    local count = 0
    for j = n + 1, 2 * n do
        local divs = numeric.propers(j)
        for _, d in ipairs(divs) do
            if j - j / d == n then
                count = count + 1
            end
        end
    end
    return count
end

function problem108alt(max, sfunc)
    local count
    local found
    local lmax = -1
    for j = 5, math.huge do
        count = sfunc(j)
        if count > lmax then
            print(count)
            lmax = count
        end
        if count > max then
            found = j
            break
        end
    end
    print(found)
end

function search(n)
    local count = 0
    for d = 1, math.sqrt(n) do
        if n % d == 0 then
            if n / d == d then
                count = count + 1
            else
                count = count + 2
            end
        end
    end
    return count
end

problem108alt(1000, search)

