#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")
memoize = require("memoize")

function contexp(n)
    if n == 0 then
        return 2
    end 
    local rem = n % 3
    if rem == 0 or rem == 1 then
        return 1
    end
    return ((n - rem) / 3 + 1) * 2
end

function sq3(n)
    if n == 0 then
        return 1
    end
    if n % 2 == 1 then
        return 1
    end
    return 2
end

function h(n, a) 
    if n == -2 then
        return bignum{0}, bignum{1}
    end
    if n == -1 then
        return bignum{1}, bignum{0}
    end
    local hp, kp = h(n - 1, a)
    local hpp, kpp = h(n - 2, a)
    local an = bignum(numeric.digits(a(n)))
    return hp:mul(an):add(hpp), kp:mul(an):add(kpp)
end
h = memoize(h)

function problem65(n)
    local hn, kn = h(n, contexp)
    local sum = hn:reduce(function(a, b) return a + b end)
    return sum, hn, kn
end

assert(problem65(9) == 17)

print(problem65(99))
