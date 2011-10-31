#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
require("numeric")

function root(n)
    return math.sqrt(n + 0.25) + 0.5
end

function problem100(max)
    --for j = from, math.huge do
    for j = 1, math.huge do
        local val = j * (j - 1)
        local b = root(val / 2)  
        if b == math.floor(b) then
            print(j, b)
            if j > max then
                break
            end
        end
    end
end

function problem100alt(max)
    for j = 1, math.huge do
        local val = j * (j - 1)
        local b = root (val * 2)
        if b == math.floor(b) then
            print(j, b, math.ceil(math.log(j) / math.log(10)), (b * (b - 1)) / (j * (j - 1)))
            if b > max then
                break
            end
        end
    end
end

function problem100f(min)
    for j = min, math.huge do
        local val = j * (j - 1)
        local b = root(val / 2)  
        if b == math.floor(b) then
            print(j, b, math.ceil(math.log(b) / math.log(10)), (j * (j - 1))/(b * (b - 1)), j > 10^12)
            break
        end
    end
end

function problem100fresh(max)
    local found = {}
    for j = 1, math.huge do
        local sq = j * j
        local a = (j  +  1) / 2
        if (sq - 1) % 4 == 0 then
            local k = (sq - 1) / 4
            found[k] = a
            if found [k / 2] then
                print(a, found[k / 2])
                if a > max then
                    return
                end
            end
        end
    end
end



function problem100guess(max)
    a, b = 3, 4
    while true do
        a, b = 3 * a + 2 * b - 2, 4 * a + 3 * b - 3
        print(a, b)
        if b > max then
            break
        end
    end
end

problem100guess(1000000000000)
--problem100fresh(1e11)
