#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function partitions(n, t, from, inner)
    --print(n, table.concat(t, " "), from)
    local rem = n / t[from]
    local res = {}
    if from == #t then
        if n % t[from] == 0 then
            return {{{t[from], n / t[from]}}}
        else
            return false
        end 
    end
    for j = 0, math.floor(rem) do
        local head = {j, t[from]}
        local ps = partitions(n - t[from] * j, t, from + 1, true)
        if ps then 
            for _, p in ipairs(ps) do
                table.insert(p, 1, head)
                table.insert(res, p)
                if not inner then
                    coroutine.yield(p)
                end
            end
        end
    end
    if inner then
        return res
    end
end

function partitions_iterator(n,t) return coroutine.wrap(function() return partitions(n, t, 1) end)end

local iterator = partitions_iterator(200, {200,100, 50, 20, 10, 5, 2, 1}, 1)
local total = 0
while true do
    local p = iterator()
    if not p then 
        break
    end
    local s = ""
    total = total + #p
    for i, v in ipairs(p) do
        s = s.." "..v[1].."*"..v[2] 
    end
    print(s)
end
print(total)
return total
--[[
for _, p in ipairs(p) do
    for _, v in ipairs(p) do
        print(v)
    end
end
]]
