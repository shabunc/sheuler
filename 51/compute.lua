#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function stars_generator(t, from) 
    for j = from, #t do
        local a = array(t)
        a[j] = '*'
        coroutine.yield(a)
        stars_generator(a, j + 1)
    end
end

function stars_iterator(t)
    return coroutine.wrap(function() return stars_generator(t, 1) end)
end

function filter_primes(t)
    local res = {}
    for j = 0, 9 do
        local a = array(t)
        for i, v in ipairs(a) do
            if v == '*' then
                a[i] = j
            end
        end
        if a[1] ~= 0 then
            local n = numeric.number(a)
            if numeric.is_prime(n) then
                table.insert(res, n)
            end
        end
    end
    return res
end

function problem51(max)
    local n = 11
    while true do
        if numeric.is_prime(n) then
            local it = stars_iterator(numeric.digits(n))
            while true do
                local seq = it()
                if not seq then
                    break
                end
                local primes_found = filter_primes(seq)
                if #primes_found == max then
                    print(table.concat(primes_found," "))
                    return primes_found
                end
            end
        end
        n = n + 2
    end
end

problem51(8)
