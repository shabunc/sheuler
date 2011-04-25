#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(t) 
    local res = {}
    for _, v in ipairs(t) do
        local found_left, found_right= true, true
        for _, left_digit in ipairs({3,5,7,9}) do
            local from_left = array.copy(v)
            table.insert(from_left, 1, left_digit)
            local num_left = numeric.digits2num(from_left)
            if numeric.is_prime(num_left) then
                local from_right = array.copy(from_left)
                local found_left = true
                while #from_right > 1 do
                    table.remove(from_right, #from_right)
                    local num_right = numeric.digits2num(from_right)
                    if not numeric.is_prime(num_right) then
                        found_left = false
                        break
                    end
                end
                if found_left then
                    print(num_left)
                    table.insert(res, from_left)
                end
            end
        end
        for _, right_digit in ipairs({3,5,7,9}) do
            local from_right = array.copy(v)
            table.insert(from_right, right_digit)
            local num_right = numeric.digits2num(from_right)
            if numeric.is_prime(num_right) then
                local from_left = array.copy(from_right)
                local found_right = true
                while #from_left > 1 do
                    table.remove(from_left, 1)
                    local num_left = numeric.digits2num(from_left)
                    if not numeric.is_prime(num_left) then
                        found_right = false
                        break
                    end
                end
                if found_right then
                    print(num_right)
                    table.insert(res, from_right)
                end
            end
        end
        if not (found_right or found_left) then
            print("LAST ONE", table.concat(v))
        end
    end
    return res
end


function problem37()
    local iterator = {{2},{3},{5},{7},{9}}
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
