#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

function expr(op, a, b) 
    if op == "*" then
        return a * b
    elseif op == "+" then
        return a + b
    elseif op == "/" then
        return a / b
    elseif op == "-" then
        return a - b
    end
end



