#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

function repunit(unit, len, base)
    local res = 0
    for j = 0, len - 1 do
        res = res + unit * base^j
    end 
    return res
end

function explore(max)
    local found = {}
    for base = 2, 100 do
        for unit = 1, base - 1  do
            local len = 2
            repeat
                local rep = repunit(unit, len, base)
                local key = rep  .. " " .. unit
                if not found[key] then
                    found[key] = {}
                end
                table.insert(found[key], base)
                len = len + 1
             until rep >  max
        end
    end
    for key, t in pairs(found) do
        if #t > 1 then
            print(key)
        end
    end
end

explore(50)
