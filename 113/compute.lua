#!/usr/bin/env lua 

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")


local iterator = numeric.integer_iterator({0}, 10000000)
while true do
    num = iterator()
    if not num then
        break
    end
    print(table.concat(num))
end
