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


function generator(n, res, nums, figs)
    if n == 0 then
        local n = 100 * res[#res] + res[1]
        local good, ind = contains_in(n, figs)
        if good then
            table.insert(nums, n)
            coroutine.yield(nums)
        end
        return
    end
    for j = 10, 99 do
        local good_n = true
        local lnums = array(nums)
        local lfigs = array(figs)
        if #res > 0 then
            local n = 100 * res[#res] + j
            good_n, ind = contains_in(n, figs)
            if good_n then
                table.insert(lnums, n)
                table.remove(lfigs, ind)
            end
        end
        if good_n then
            local lres = array(res)
            table.insert(lres, j)
            generator(n - 1, lres, lnums, lfigs)
        end
    end
end


function iterator(n, figs)
    return coroutine.wrap(function()
        return generator(n, {}, {}, figs)
    end)
end

function problem61()
    local TRIS = collect(tri, 10^3, 10^4)
    local SQS = collect(square, 10^3, 10^4)
    local PENTAS = collect(penta, 10^3, 10^4)
    local HEXAS = collect(hexa, 10^3, 10^4)
    local HEPTAS = collect(hepta, 10^3, 10^4)
    local OCTAS = collect(octa, 10^3, 10^4)
    local FIGS = {TRIS, SQS, PENTAS, HEXAS, HEPTAS, OCTAS}
    local it = iterator(6, FIGS)
    while true do
        local seq = it()
        if not seq then
            break
        end     
        print(table.concat(seq," "))
        print(array.reduce(seq, function(a, b) return a + b end))
    end
end

problem61()
