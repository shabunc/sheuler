#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("iterator")

function points(n)
    local res = {}
    for j = 0, n do
        for i = 0, n do
            if not ((j == 0) and (i == 0)) then
                table.insert(res,{j, i})
            end
        end
    end
    return res
end

function problem91(n)
    local res = {}
    local it = iterator.combinations(2, points(n))
    while true do
        local seq = it()
        if not seq then
            break
        end
        print(table.concat(seq[1],","), table.concat(seq[2], ","))
    end
end

problem91(2)
