#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(t) 
    local res = {}
    for _, v in ipairs(t) do
        local found_left, found_right= true, true
        for _, left_digit in ipairs({1, 2, 3, 4, 5, 6, 7, 8, 9}) do
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
                    coroutine.yield(num_left)
                    table.insert(res, from_left)
                end
            end
        end
        for _, right_digit in ipairs({3, 7, 9}) do
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
                    coroutine.yield(num_right)
                    table.insert(res, from_right)
                end
            end
        end
    end
    if #res > 0 then
        step(res)
    end
end


function problem37()
    local this_step = {{2},{3},{5},{7}}
    local iterator = coroutine.wrap(function(t) return step(t) end)
    local res = {}
    while true do 
        local n = iterator(this_step)
        if not n then
            break
        end
        array.insert_sorted(res, n)
    end
    print(table.concat(res," "), "#", #res)
    print(array.reduce(res, function(a, b) return a + b end))
end

problem37()
