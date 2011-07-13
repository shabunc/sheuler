#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function mul_generator(n)
    if numeric.is_prime(n) then
        coroutine.yield(n)
        return
    end

end
