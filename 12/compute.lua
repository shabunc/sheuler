#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function nth(n)
    return (n+1) * n * 0.5
end

function problem12(max, nth)
    local n = 1
    while true do
        local fn = nth(n)
        local divs = numeric.alldivisors(fn)
        print(fn, #divs)
        if #divs > max then
            break
        end
        n = n + 1
    end
    print(nth(n), n)
    return n
end

problem12(500, nth)
