#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

function repunit(unit, len, base)
    local res = 0
    for j = 0, len - 1 do
        res = res + unit * base^j
    end 
    return res
end

