#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

--[[
    MINUS NUMBER | EXPRESSION
    PLUS  (NUMBER | EXPRESSION) *
    MUL   (NUMBER | EXPRESSION)
    DIV   (NUMBER | EXPRESSION) (NUBER | EXPRESSION)
]]

function express(op, ...)
    if op == 'e' then
        return select(1, ...)
    end
    if op == '-' then
        local a = select(1, ...)
        return -a
    end
    if op == '/' then
        local a = select(1, ...)
        local b = select(2, ...)
        return a / b
    end
    if op == '+' then
        local sum = 0
        for i, v in ipairs{...} do
            sum = sum + v
        end
        return sum
    end
    if op == '*' then
        local prod = 1
        for i, v in ipairs{...} do
            prod = prod * v
        end
        return prod
    end
end

assert(express("-", 5) == -5)
assert(express("+", 1, 2, 3) == 6)
assert(express("*", 1, 2, 3, 4) == 24)
assert(express("/", 20, 5) == 4)

function express_generator(nums)
    if #nums == 1 then
        ops = {"e", "-"}
    end
    if #nums == 2 then 
        ops = {"e", "-", "+", "/"}
    end
    if #nums > 2 then
        ops = {"e", "-", "+", "/", "*"}
    end
    for _, op in ipairs(ops) do
        if op == "-" then
            for j = 1, #nums do
                local lnums = array(nums)
                local head = lnums[j]
            end
        end
    end
end
