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

assert(#chain(gen_poly(1, 41)) == 40)
assert(#chain(gen_poly(-79, 1601)) == 80)
