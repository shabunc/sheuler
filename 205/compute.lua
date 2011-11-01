#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

function revert(t, a, b)
    local a = a or 1
    local b = b or #t
    for j = a, a + (b - a) / 2  do
        t[j], t[b - j + a] = t[b - j + a], t[j]
    end
end

function perm(a)
    local k = #a - 1
    while a[k] > a[k + 1] do
        k = k - 1
        if k == 0 then
            return false
        end
    end
    local m = k + 1
    for j = k + 2, #a do
        if a[j] > a[k] then
            m = j
        end
    end
    a[k], a[m] = a[m], a[k]
    revert(a, k + 1, #a)
    return a
end

function asc(a, min, max)
    local k = #a
    while not (a[k] < max) do
        k = k - 1
        if k == 0 then
            return false
        end
    end
    a[k] = a[k] + 1
    for j = k + 1, #a do
        a[j] = min
    end
    return a
end


function simpleit()
    local n = nil
    local m = 5
    return function() 
        return m, n
    end
end

for j, m in simpleit() do
    print(j, m)
end
