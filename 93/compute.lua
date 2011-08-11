#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
require "numeric"

function operation(op, a, b) 
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

function form1(ops, digs)
    local a  = operation(ops[3], digs[1], digs[2])
    local b = operation(ops[2], a, digs[3])
    local c = operation(ops[1], b, digs[4])
    return c
end

function form2(ops, digs)
    local a = operation(ops[3], digs[1], digs[2])
    local b = operation(ops[2], digs[3], digs[4])
    local c = operation(ops[1], a, b)
    return c
end

function iterator(t, n)
    local function gen(t, len, res)
        if len == 0 then
            coroutine.yield(res)
            return
        end
        for j = 1, #t do
           local lres = array(res) 
           table.insert(lres, t[j])
           gen(t, len - 1, lres)
        end
    end
    return coroutine.wrap(function() 
        return gen(t, n, {})
    end)
end

function isint(n)
    return n == math.floor(n)
end

function isgood(n)
    return isint(n) and n > 0
end

function getall(digs) 
    local it = iterator({"+","*","/","-"}, 3)
    local res = array{}
    while true do
        local ops = it()
        if not ops then
            break
        end
        local a = form1(ops, digs)
        local b = form2(ops, digs)
        if isgood(a) then
            table.insert(res, a)
        end
        if isgood(b) then
            table.insert(res, b)
        end
    end
    table.sort(res)
    res = res:uniq()
    print(table.concat(res, " "))
    return res
end

getall({1,2,3,4})
