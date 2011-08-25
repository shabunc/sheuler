#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

function square(from, till)
    return function(state, n) 
        if n < state then
            n = n + 1
            return n, n*n, 2
        end
    end, till, from
end

function fixed_combs(k, n)
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

for seq in fixed_combs(4, 5) do
    print(table.concat(seq))
end
