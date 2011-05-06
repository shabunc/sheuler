#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function problem13(filename)
    local res = bignum{0}
    local file = io.open(filename, "r")
    for line in file:lines() do
        local digs = {}
        for digit in string.gmatch(line, ".") do
            table.insert(digs, tonumber(digit))
        end
        res = res:add(bignum(digs))
    end
    file:close()
    return res, array(res, 1, 10)
end

print(problem13("data.txt"))
