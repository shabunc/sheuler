#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(t) 
    local res = {}
    for i, v in pairs(t) do
        for _, j in ipairs({1,3,5,7,9}) do
            local a = array.copy(v)
            table.insert(a, 1, j)
            local left_n  = numeric.digits2num(a)
            if numeric.is_prime(left_n) then
                print(#a, table.concat(a))
                for _, k in ipairs({1,3,7,9}) do
                    local b = array.copy(v)
                    table.insert(b, k)
                    local right_n = numeric.digits2num(b)
                    if numeric.is_prime(right_n) then
                        table.insert(a, k)
                        if numeric.is_prime(numeric.digits2num(a)) then
                            table.insert(res, a)
                        end
                    end
                end
            end
        end
    end
    return res
end


function problem37()
    local iterator = {{}}
    local iterator = {{},{2},{3},{5},{7}}
    local count = 1
    while true do 
        if count > 4 then
            break
        end
        iterator = step(iterator)
        for _, v in ipairs(iterator) do
            print(table.concat(v))
        end
        print("=======")
        count = count + 1
    end
end

problem37()
