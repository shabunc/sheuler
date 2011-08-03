#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function f(n) 
    for j = 1, math.huge do 
        local m = j * n
        local digs = numeric.digits(m)
        if array.every(digs, function(d) return d <3 end) then
            return m, j
        end
    end
end

function ff(n)
    local sum = 0
    for j = 1, n do
        local res = f(j)
        print(j, res)
        sum = sum + res
    end
    return sum
end

function diadic(n)
    local function gen(n) 
    end
    return coroutine.wrap(function() 
        return gen(n, {})
    end)
end

print(ff(10))
