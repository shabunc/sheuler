#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function combit(t, n)
    local function gen(t, n, from, res)
        if n == 0  then
            coroutine.yield(res)
            return
        end
        for j = from, #t do
            local lres = array(res)
            table.insert(lres, t[j])
            gen(t, n - 1, j + 1, lres)
        end
    end
    return coroutine.wrap(function() 
        return gen(t, n, 1, {})
    end)
end

function squares(max)
    local res = {}
    for j = 1, max do
        table.insert(res, j * j)
    end
    return res
end

function search(max)
    local sqs = squares(max)
    local abit = combit(sqs, 2) 
    while true do
        local seq = abit()
        if not seq then
            break
        end
        local a, b = seq[1], seq[2]
        local cdit = combit(sqs, 2)
        while true do
            local seq = cdit()
            if not seq then
                break
            end
            local c, d = seq[1], seq[2]
            if a ~= c and a + b == c + d then
                local efit = combit(sqs, 2)
                while true do
                    local seq = efit()
                    if not seq then
                        break
                    end
                    local e, f = seq[1], seq[2]
                    if e ~= c and f - e == d - c then
                        print(a, b, c, d, f, e, b - a)
                        if e + f == b - a then
                            print("FOUND!", a, b, c, d, f, e)
                            return
                        end
                    end
                end 
            end
        end
    end
end

search(200)
