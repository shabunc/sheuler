#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function mul_generator(n)
    if numeric.is_prime(n) then
        return {n}
    end
    local props = numeric.propers(n)
    for j = 2, #props - 1 do 

    end
end
