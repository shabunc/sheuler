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

problem100f(1e12)
