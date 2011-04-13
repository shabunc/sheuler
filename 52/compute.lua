#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function problem52(n)
    local ints = numeric.integer_iterator({1})
    while true do
        int = ints()
        local found = true
        local prod = numeric.digits2num(int)
        local iterator = prod
        for j = 2, n  do
            iterator = j * prod
            local digits = numeric.num2digits(iterator)
            found = found and array.are_permutations(digits, int)
        end
        if found then
            return numeric.digits2num(int)
        end
    end
    return false
end

print(problem52(6))
