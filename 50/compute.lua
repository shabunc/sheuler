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

function partitions_generator(n, t, from, inner) 
    local rem = n / t[from]
    local res = {}
    if from == #t then
        if n % t[from] == 0 then
            return {{{ n / t[from], t[from]}}}
        else
            return false
        end 
    end
    for j = 0, math.floor(rem) do
        local head = {j, t[from]}
        local ps = partitions_generator(n - t[from] * j, t, from + 1, true)
        if ps then 
            for _, p in ipairs(ps) do
                table.insert(p, 1, head)
                table.insert(res, p)
                if not inner then
                    setmetatable(p, { __tostring = serialize_partition })
                    coroutine.yield(p)
                end
            end
        end
    end
    if inner then
        return res
    end
end

function partitions_iterator(n, t)
    return coroutine.wrap(function() return partitions_generator(n, t, 1) end)
end

function problem50(n) 
   local it = partitions_iterator(n, get_primes(n)) 
   while true do
        local seq = it()
        if not seq then
            break
        end
        print(seq)
   end
end

problem50(20)
