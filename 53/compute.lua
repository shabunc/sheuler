#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

local FACTCACHE = {}

function bigfact(n)
    if n == 0 then
        return bignum{1}
    end
    if FACTCACHE[n] then
        return FACTCACHE[n]
    end
    local res = bigfact(n - 1):mul(bignum(numeric.digits(n)))
    FACTCACHE[n] = res
    return res
end

print(bigfact(10))
