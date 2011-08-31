#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("array")

function merge(ta, tb)
    local a = 1
    local b = 1
    local res = {}
    while a < #ta and b < #tb do
        if ta[a] == tb[b] then
            table.insert(res, ta[a]) 
            a = a + 1
            b = b + 1
        elseif ta[a] < tb[b] then
            table.insert(res, ta[a])
            a = a + 1
        else
            table.insert(res, tb[b])
            b = b + 1
        end
    end
    if a < #ta then
        for j = a, #ta do
            table.insert(res, ta[j])
        end
    else
        for j = b, #tb do
            table.insert(res, tb[j])
        end
    end
    return res
end

print(table.concat(merge({1, 7, 9}, {2, 3, 9, 11}), " "))
