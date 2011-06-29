#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

dofile("cipher1.txt")

function freqs(data)
    local res = {}
    for _, v in ipairs(data) do
        if not res[v] then
            res[v] = 0
        end
        res[v] = res[v] + 1
    end
    local freqs = {}
    for k, v in pairs(res) do
        table.insert(freqs, {k, v})
    end
    table.sort(freqs, function(a, b) return a[2] < b[2] end)
    return freqs
end

for _, v in ipairs(freqs(DATA)) do
    print(v[1], v[2])
end
