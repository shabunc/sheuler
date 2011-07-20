#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function pow(n)
    if n == 0 then
        return 0, 1
    end
    if n % 2 == 0 then
        local a, b = pow(n / 2)
        return 2 * a * b - a^2, a^2 + b^2
    else
        local a, b = pow(n - 1)
        return b, a + b
    end
end

function fib(n)
    local _, res = pow(n)
    return res
end

print(fib(5))
