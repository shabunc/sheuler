#!/usr/bin/env lua

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

co = numeric.combinations_iterator(4, {1,2,3,4,5,6,7,8,9})
while true do
    local comb = co()
    if not comb then
        break
    end
    local res = array.copy(comb)
    local n = numeric.digits2num(comb)
    local iterator = n
    local found = false
    times = 1
    while true do
        times = times + 1
        iterator = times * n
        local digs  = numeric.num2digits(iterator)
        array.join(res, numeric.num2digits(iterator))
        if #res > 9 then
            break
        end
        if #res == 9 then
            found = true
            break
        end
    end
    if found then
        local sorted = array.copy(res)
        table.sort(sorted)
        if sorted[1] ~= 0 then
            if numeric.digits2num(sorted) == 123456789 then
                print(table.concat(res))
            end
        end
    end
end
