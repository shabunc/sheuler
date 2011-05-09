#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function chain(func)
    local n = 0
    local res = {}
    while true do
        local fa = func(n)
        if not numeric.is_prime(fa) then
            break
        end
        table.insert(res, fa)
        n = n + 1
    end
    return res
end

function gen_poly(a, b)
    return function(n)
        return n^2 + a*n + b
    end
end

function problem27()
    local max = -1
    local res
    for b = 0, 1000 do
        for a = -999, 1 - b, 2  do
            if numeric.is_prime(b) then
                local ch = chain(gen_poly(a, b))
                if #ch > max then
                    print(a, b, #ch)
                    max = #ch
                    res = a * b
                end
            end
        end
    end
    print("MAX", max)
    print("RES", res)
    return max, res
end

assert(#chain(gen_poly(1, 41)) == 40)
assert(#chain(gen_poly(-79, 1601)) == 80)

problem27()
--print(table.concat(chain(gen_poly(-999, 61))," "))
