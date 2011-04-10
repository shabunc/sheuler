#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

dofile("data.lua")

function analize(data)
    local res = {}
    local test_key = function(key)
        if not res[key] then
            res[key] = {
                ["before"] = {},
                ["after"] = {}
            }
        end
    end
    for _, hash in ipairs(data) do
        local digits = numeric.num2digits(hash)
        test_key(digits[1])
        test_key(digits[2])
        test_key(digits[3])
        table.insert(res[digits[1]].before, digits[2])
        table.insert(res[digits[1]].before, digits[3])
        table.insert(res[digits[2]].after, digits[1])
        table.insert(res[digits[2]].before, digits[3])
        table.insert(res[digits[3]].after, digits[1])
        table.insert(res[digits[3]].after, digits[2])
    end
    inspect(res)
end

function inspect(data)
    for k, info in pairs(data) do
        print(k)
        print("before", #info.before)
        print(table.concat(info.before," "))
        print("after", #info.after)
        print(table.concat(info.after," "))
    end
end

analize(DATA)
