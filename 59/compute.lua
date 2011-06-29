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

function xor(a, b) 
    return (a + b) - (a and b) * 2
end

function decipher(key, message)
    local deciphered = array{}
    for i, v in ipairs(message) do
       local ch = string.byte(key[i % #key + 1])
       local dch = xor(ch, v)
       table.insert(deciphered, string.char(dch))
    end
    return deciphered
end

--[[
for _, v in ipairs(freqs(DATA)) do
    print(v[1], v[2])
end
]]

print(decipher({"a", "b", "c"}, DATA))
