#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function nextdig(head, lim)
    local dig
    for j = 0, 9 do
        local num = bignum(head)
        table.insert(num, j)
        local test = array(num:mul(num), 1, #lim)
        if test ~= lim then
            dig = j - 1
            break
        end
    end
    print(dig)
    return dig
end

nextdig(bignum{1}, array{1})

