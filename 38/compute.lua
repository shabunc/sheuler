#!/usr/bin/env lua

function copy(t) 
    local res = {}
    for j in ipairs(t) do
        res[j] = t[j]
    end
    return res
end

function combinations(k, t) 
    if k == 0 then
        return {{}}
    end
    local res = {}
    for i, head in ipairs(t) do
        local tail = copy(t)
        table.remove(tail, i)
        local combs = combinations(k - 1, tail)
        for j, comb in ipairs(combs) do
            table.insert(comb, 1, head)
            table.insert(res, comb)
        end
    end
    return res
end

combs = combinations(3,{1,2,3,4,5,6,7,8,9})
