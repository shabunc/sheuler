#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function get_primes(n) 
    local res  = {2}
    for j = 3, n, 2 do
        if numeric.is_prime(j) then
            table.insert(res, j)
        end
    end
    return res
end

local serialize_partition = function(t)
    local s = ""
    for i, v in ipairs(t) do
        s = s  .. v[1] .. "*" .. v[2] .. " "
    end
    return s
end

STATES = {
    ["INITIAL"] = {
        [0] = "WAITING_ONE",
        [1] = "WAITING_ZERO"
    },
    ["WAITING_ONE"] = {
        [0] = "WAITING_ONE",
        [1] = "WAITING_ZERO"
    },
    ["WAITING_ZERO"] = {
        [0] = "ZEROS_ONLY",
        [1] = "WAITING_ZERO"
    },
    ["ZEROS_ONLY"] = {
        [0] = "ZEROS_ONLY",
        [1] = "TERMINATE"
    },
    ["TERMINATE"] = {
        [0] = "TERMINATE",
        [1] = "TERMINATE"
    }
}


function partitions_generator(n, t, from, state, card) 
    if state == "TERMINATE" then
        return false
    end
    local rem = n / t[from]
    local res = {}
    if from == #t then
        if n % t[from] == 0 then
            return {{{ n / t[from], t[from]}}}
        else
            return false
        end 
    end
    local a = 0
    local b = math.min(math.floor(rem), 1)
    for j = a, b do
        local head = {j, t[from]}
        local ps = partitions_generator(n - t[from] * j, t, from + 1, STATES[state][j], card + j)
        if ps then 
            for _, p in ipairs(ps) do
                table.insert(p, 1, head)
                table.insert(res, p)
                if state == "INITIAL" then
                    setmetatable(p, { __tostring = serialize_partition })
                    coroutine.yield(p)
                end
            end
        end
    end
    if state ~= "INITIAL" then
        return res
    end
end

function partitions_iterator(n, t)
    return coroutine.wrap(function() return partitions_generator(n, t, 1, "INITIAL", 0) end)
end

function count(n) 
   local it = partitions_iterator(n, get_primes(n - 1)) 
   local max = 0
   while true do
        local seq = it()
        if not seq then
            break
        end
        local card = array.reduce(seq, function(a, b) return a + b[1] end)
        if card > max then
            max = card
        end
   end
   return max
end

function problem50brute(lim)
    local max = 0
    local res = -1
    for j = 3, lim, 2 do
        if numeric.is_prime(j) then
            print(j)
            local lmax = count(j)
            if lmax > max then
                max, res = lmax, j
            end
        end
    end
    return res, max
end

local function sum_generator(n, parts, inner) 
    if parts == 1 then
        return {{n}}
    end
    local res = {}
    local a, b, step = 0, n - parts - 1, 1
    if parts == 2 then
       a, b = b, a
       step = -1
    end
    for head = a, b, step do
        local tail = sum_generator(n - head, parts - 1, true)
        for _, v in ipairs(tail) do
            table.insert(v, 1, head)
            table.insert(res, v)
            if not inner then
                coroutine.yield(v)
            end
        end
    end
    if inner then
        return res
    end
end

local sum_iterator = function(n, parts) 
    return coroutine.wrap(function() return sum_generator(n, parts) end)
end

function problem50(lim)
    local primes = get_primes(lim)
    print("PRIMES", #primes)
    local it = sum_iterator(#primes, 3)
    local max = 0
    local res = false
    while true do
        local seq = it()
        if not seq then 
            break
        end
        if  seq[2] ~= 1 and (seq[1] == 0 and seq[2] % 2 == 0) or (seq[1] ~= 0 and seq[2] % 2 == 1) then
            local from = seq[1] + 1
            local to = from + seq[2] - 1
            local pr_seq = array(primes, from, to)
            local sum = 0
            for j = 1, #pr_seq do
                sum = sum + pr_seq[j]                
                if sum > lim then
                    sum = 0
                    break
                end
            end
            if sum > 0 and numeric.is_prime(sum) then
                --print(table.concat(seq," "),"\t", table.concat(pr_seq," "), "\t",sum)
                if seq[2] > max then
                    max = seq[2] 
                    res = {pr_seq, sum}
                    print(sum, max,  table.concat(pr_seq, "+"))
                end
            end
        end
    end
    return res[1], res[2]
end

assert(#problem50(100) == 6)
assert(#problem50(1000) == 21)

primes, sum = problem50(1000000)
print(sum, #primes, table.concat(primes,"+"))

--[[
local it = sum_iterator(25, 3)
while true do
    local seq = it()
    if not seq then
        break
    end
    print(table.concat(seq," "))
end
]]
