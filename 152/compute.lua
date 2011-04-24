#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bigint")

function get_vector(case)
    local res = {}
    for i, v in ipairs(case) do
        if v ~= 0  then
            table.insert(res, i + 1)
        end
    end
    return res
end

function problem152(from, to)
    local case = bigint:new({1}, 2)
    while case:len() < (to - from) do
        local prod = bigint:new{1}
        case = case:add(bigint:new({1}, 2))
        for i, v in ipairs(case.num) do
            if v == 1 then
                local big = bigint:new(numeric.num2digits(i + 1))
                prod = prod:mul(big)
            end
        end
        print(prod)
    end
end

problem152(2, 45)
