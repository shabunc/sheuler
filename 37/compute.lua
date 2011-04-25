#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(t) 
    local res = {}
    for _, v in ipairs(t) do
        for _, left_digit in ipairs({1,2,3,4,5,6,7,8,9}) do
            local from_left = array.copy(v)
            table.insert(from_left, 1, left_digit)
            local num_left = numeric.digits2num(from_left)
            if numeric.is_prime(num_left) then
                local from_right = array.copy(from_left)
                local found = true
                while #from_right > 1 do
                    table.remove(from_right, #from_right)
                    local num_right = numeric.digits2num(from_right)
                    if not numeric.is_prime(num_right) then
                        found = false
                        break
                    end
                end
                if found then
                    print(num_left)
                    table.insert(res, from_left)
                end
            end
        end
    end
    return res
end


function problem37()
    local iterator = {{2}, {3}, {5}, {7}}
    local count = 1
    while true do 
        if count > 6 then
            break
        end
        iterator = step(iterator)
        count = count + 1
    end
end

problem37()
