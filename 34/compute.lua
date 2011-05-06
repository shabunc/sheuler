#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function is_curious(n, func) 
    if n == 1 or n == 2 then
        return false, 0
    end
    local digs = numeric.digits(n)
    local nfsum = array.reduce(digs, function(a, b) return a + func(b) end)
    return nfsum == n, nfsum
end

function problem34()
    local n = 1
    while true do
        local curious, actual_sum = is_curious(n, numeric.factorial)
        if curious then
            print(n)
        end
        n = n + 1
    end
end

assert(is_curious(145, numeric.factorial) == true)

problem34()
