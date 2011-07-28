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
    for a = 2, math.huge do
        local divs = numeric.propers(a)
        for d = 2, #divs do
            --local n = (a / divs[d]) * (divs[d] - 1)
            local n = a - (a / divs[d]) 
            print(n, a, divs[d])
            if not res[n] then
                res[n] = 0
            end
            res[n] = res[n] + 1
            if res[n] > lmax then
                lmax = res[n]
                --print(lmax)
            end
            if res[n] > max then
                print(string.format("MAX=%i N=%i #divs=%i", res[n], n, #numeric.propers(n)))
                return
            end
        end
    end
end

function altsearch(n) 
    local count = 0
    for j = n + 1, math.huge do
        local divs = numeric.propers(j)
        for _, d in ipairs(divs) do
            if j - j / d == n then
                --print(j, d, j - j/d)
                count = count + 1
                if d == 2 then
                    --print("COUNT", count)
                    return count
                end
            end
        end
    end
end

function problem108alt(max)
    local count
    local found
    for j = 5, math.huge do
        count = altsearch(j)
        print(count, j)
        if count > max then
            found = j
            break
        end
    end
    print(found)
end

problem108(50)
--problem108alt(50)

