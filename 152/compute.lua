#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bigint")

function sums(vector)
    for j = 1, #vector do
        for k = 1, #vector do
            if j ~= k then

            end
        end
    end
end

function problem152(from, to)
    local case = bigint:new({1}, 2)
    while case:len() < (to - from) do
        local vector = {}
        case = case:add(bigint:new({1}, 2))
        for i, v in ipairs(case.num) do
            if v == 1 then
                local big = bigint:new(numeric.num2digits(i + 1))
                table.insert(vector, big)
            end
        end
        print(vector)
    end
end

problem152(2, 45)
