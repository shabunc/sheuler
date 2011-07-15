#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")


function tri(n) 
    return n * (n + 1) * 0.5
end

function square(n)
    return n * n
end

function penta(n)
    return n * (3 * n - 1) * 0.5
end

function hexa(n)
    return n * (2 * n - 1)
end

function hepta(n)
    return n * (5 * n - 3) * 0.5
end

function octa(n)
    return n * (3 * n - 2)
end

function collect(func, from, to)
    local res = {}
    for j = 1, math.huge do
        if func(j) > to then
            break
        end
        if func(j) >= from then
            res[func(j)] = true
        end
    end
    return res
end

function contains_in(el, list)
    for _, v in ipairs(list) do
        if v[el] then
            return true, _
        end
    end
    return false
end

function are_different(list)
    for i = 1, #list - 1 do
        for j = i + 1, #list do
            if list[i] == list[j] then
                return false
            end
        end
    end
    return true
end

function problem61()
    local tris = collect(tri, 10^3, 10^4)
    local sqs = collect(square, 10^3, 10^4)
    local pentas = collect(penta, 10^3, 10^4)
    local figs = {tris, sqs, pentas}
    for t = 10, 99 do
        for s = 10, 99 do
            for p = 10, 99 do
                local n1 = 100 * t + s
                local c1, i1 = contains_in(n1, figs)
                local n2 = 100 * s + p
                local c2, i2 = contains_in(n2, figs)
                local n3 = 100 * p + t
                local c3, i3 = contains_in(n3, figs)
                if c1 and c2 and c3 then
                    if are_different({i1, i2, i3}) then
                        print(n1, n2, n3, i1, i2, i3)
                    end
                end
            end
        end
    end
end

problem61()
