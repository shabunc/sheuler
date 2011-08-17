#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("array")

dofile("sets.txt")

function biterator(n)
    local function gen(n, t)
        if n == 0 then
            coroutine.yield(t)
            return
        end
        for j = 0, 1 do
            local lt = array(t) 
            table.insert(lt, j)
            gen(n - 1, lt)
        end
    end
    return coroutine.wrap(function() 
        return gen(n, {})
    end)
end

function subseq(seq, bitmask)
    local sub, cosub = {}, {}
    for i, b in ipairs(bitmask) do
        if b == 1 then
            table.insert(sub, seq[i])
        else
            table.insert(cosub, seq[i])
        end
    end
    return sub, cosub
end

function sum(t)
    return array.reduce(t, function(a, b) return a + b end)
end

function insert(t, val)
    if val < t[1] then
        table.insert(t, 1, val)
        return t
    end
    if val > t[#t] then
        table.insert(t, val)
    end
    for j = 1, #t do
        if t[j] == val then
            return false
        end
    end
end

function is_good_clever(t)
    local bit = biterator(#t)
    local buckets = {}
    while true do
        local bitmask = bit()
        if not bitmask then
            break            
        end
        local card = sum(bitmask)
        local seq = subseq(t, bitmask)
        local val = sum(seq)
        if not buckets[card] then
            buckets[card] = {}
        end
        table.insert(buckets[card], val)
    end
    for _, b in ipairs(buckets) do
        b = array.uniq(b)
        print(_,  table.concat(b, " "))
    end
    return buckets
end

function is_good(t)
    table.sort(t)
    local bit = biterator(#t)
    while true do
        local bitmask = bit()
        if not bitmask then
            break
        end
        local seq, cosub = subseq(t, bitmask)
        local cobit = biterator(#cosub)
        while true do
            local cobitmask = cobit()
            if not cobitmask then
                break
            end
            local coseq = subseq(cosub, cobitmask)
            local sa, sb = sum(seq), sum(coseq)
            if sa == sb then
                if sa > 0 then
                    return false
                end
            elseif #seq > #coseq and sa < sb then
                return false
            elseif #seq < #coseq and sa > sb then
                return false
            end
        end
    end
    return true
end

function problem105(data)
    local total = 0
    for _, t in ipairs(data) do
        print(_)
        if is_good(t) then
            total = total + sum(t)
        end
    end
    print("TOTAL", total)
    return total
end

is_good_clever{81, 88, 75, 42, 87, 84, 86, 65} 
        
--[[
assert(is_good({81, 88, 75, 42, 87, 84, 86, 65}) == false)
assert(is_good({157, 150, 164, 119, 79, 159, 161, 139, 158}) == true)

problem105(DATA)
]]
