#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"
require "numeric"
require "iterator"

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

function iteratorall(t, n)
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

function find_len(t)
    local len = 1
    for j = 2, #t do
        if t[j] - t[j - 1] ~= 1 then
            break
        end
        len = len + 1
    end
    return len
end

function getall(digs) 
    local res = array{}
    local dit = iterator.perm_lex(digs)
    while true do
        local ds = dit()
        if not ds then
            break
        end     
        local oit = iteratorall({"+","-","/","*"}, 3)
        while true do
            local ops = oit()
            if not ops then
                break
            end
            local a = form1(ops, ds)
            if isgood(a) then
                table.insert(res, a)
            end
            local b = form2(ops, ds)
            if isgood(b) then
                table.insert(res, b)
            end
        end
    end
    table.sort(res)
    res = res:uniq()
    return res
end

function problem93()
    local max = -1
    for n = 1000, 9999 do
        local digs = numeric.digits(n)
        local seq = getall(digs)
        local len = find_len(seq)
        if len > max then
            max = len
            print(n, len)
        end
    end
end

problem93()
