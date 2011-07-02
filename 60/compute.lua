#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function remarkable_pair(a, b)
    local testa = numeric.is_prime(numeric.concat(a, b))
    local testb = numeric.is_prime(numeric.concat(b, a))
    return testa and testb
end

assert(remarkable_pair(3, 109))
assert(not remarkable_pair(2, 109))

