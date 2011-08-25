#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("array")

function fixed_subs(k, n)
    local t = {}
    for j = 1, n - k do
        t[j] = 0
    end
    for j = n - k + 1, n do
        t[j] = 1
    end
    local firstone = true
    local function nextfixed(_, t)
        if firstone then
            firstone = false
            return t
        end
        local n = #t
        local s = n - 1
        while s > 0 and not (t[s] == 0 and t[s + 1] == 1) do
            s = s - 1
        end
        if s > 0 then
            local len = 0
            for j = s, n do
                len = len + t[j]
            end
            t[s] = 1
            for j = s + 1, n - len + 1 do
                t[j] = 0
            end
            for j = n - len + 2, n do
                t[j] = 1
            end
            return t
        end
    end
    return nextfixed, 0, t
end

function next_decreasing(t, k, n)
    local s = n
    while s > 0 and not(t[s] and t[s] < n - k + s) do
        s = s - 1
    end
    if s == 0 then
        return
    end
    t[s] = t[s] + 1
    for j = s + 1, k do
        t[j] = t[j - 1] + 1
    end
    return t
end

function dec_iterator(k, n)
    local t = {}
    for j = 1, k do
        t[j] = j
    end
    local firstone = true
    local function gen(_, t)
        if firstone then
            firstone = false
            return t
        end
        return next_decreasing(t, k, n)
    end
    return gen, 0, t
end 

function get_sub(t, sub)
    local res = {}
    for j = 1, #sub do
        if sub[j] == 1 then
            table.insert(res, t[j])
        end 
    end
    return res
end

function is_good(t)
    local lookup = {}
    local min = math.huge
    for j = #t, 1, -1 do
        local lmin = math.huge
        for sub in fixed_subs(j, #t) do
            local seq = get_sub(t, sub)
            local sum = array.reduce(seq, function(a, b) return a + b end)
            if lookup[sum] then
                return false
            end
            lookup[sum] = 1
            if lmin > sum then
                lmin = sum
            end
            if lmin > min then
                return false
            end
        end
        min = lmin
    end
    return true
end

function problem103(k)
    local min = math.huge
    for seq in dec_iterator(k, 50) do
        if is_good(seq) then
            local sum = array.reduce(seq, function(a, b) return a + b end)
            if sum < min then
                min = sum
                local res = array.reduce(seq, function(a, b) return a .. tostring(b) end, "")
                print(res)
            end
        end
    end
end

problem103(7)
