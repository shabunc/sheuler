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

--[[
function xor(a, b) 
    return math.abs((a + b) - (a and b) * 2)
end
]]

--http://lua-users.org/wiki/BitUtils
function xor(x, y)
   local z = 0
   for i = 0, 31 do
      if (x % 2 == 0) then                      -- x had a '0' in bit i
         if ( y % 2 == 1) then                  -- y had a '1' in bit i
            y = y - 1 
            z = z + 2 ^ i                       -- set bit i of z to '1' 
         end
      else                                      -- x had a '1' in bit i
         x = x - 1
         if (y % 2 == 0) then                  -- y had a '0' in bit i
            z = z + 2 ^ i                       -- set bit i of z to '1' 
         else
            y = y - 1 
         end
      end
      y = y / 2
      x = x / 2
   end
   return z
end

function cipher(key, message)
    local ciphered = array{}
    for i, v in ipairs(message) do
       local ch = string.byte(key[i % #key + 1])
       local dch = xor(v, ch)
       table.insert(ciphered, dch)
    end
    return ciphered
end

function brute() 
    local l = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
    for _, a in ipairs(l) do
        for _, b in ipairs(l) do
            for _, c in ipairs(l) do
                print("========", a, b, c)
                print(chars(cipher({a, b, c}, DATA)))
            end
        end
    end
end

function bytes(s) 
    local res = array{}
    for j = 1, string.len(s) do
        table.insert(res, string.byte(string.sub(s, j, j)))
    end
    return res
end

function chars(t) 
    local res = array{}
    for j = 1, #t do
        table.insert(res, string.char(t[j]))
    end
    return res
end

brute()

--[[
local key = {"a"}
local m = cipher(key, bytes("a secret secret message"))
print(chars(cipher(key, m)))
]]
