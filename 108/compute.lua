#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function search(n)
    local count = 0
    local lasty = 1
    for j = 1, math.huge do
        local b = j * n
        local to = math.min(math.sqrt(b), b / lasty)
        for d = 1, to do
            if b % d == 0 then
                local x = d
                local y = b / d
                if x + y == j then
                    count = count + 1
                    --print(x, y, y / x, count, to == math.sqrt(b))
                    lasty = y
                    if x == n + 1 then
                        return count
                    end
                end
            end
        end
    end
end


function f(ta)
    if #ta == 0 then
        return 1
    end
    local res = 0
    for j = 1, #ta do
        local lta = array(ta)
        local head = table.remove(lta, j)
        res = res + head * f(lta)
    end
    return res + 1
end

--[[
]]
for j = 1, 4 do
    local i = 2
    local n = 2^j * 3 * 5
    print(search(n), f{j, 1, 1})
end
