#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

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

for seq in dec_iterator(3,5) do
    print(table.concat(seq))
end
