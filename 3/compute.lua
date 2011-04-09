#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"
require("numeric")

d = numeric.divisors(600851475143)
for k,v in pairs(d) do
    print(k,v)
end
