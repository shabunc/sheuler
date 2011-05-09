require("array")

iterator = {}

local generator = {}

generator.combinations = function(k, t, k_caller)
    if k == 0 then
        return {{}}
    end
    local res = {}
    for i, head in ipairs(t) do
        local tail = array(t)
        table.remove(tail, i)
        local combs = generator.combinations(k - 1, tail, k)
        for j, comb in ipairs(combs) do
            table.insert(comb, 1, head)
            table.insert(res, comb)
            if k == k_caller then
                coroutine.yield(comb)
            end
        end
    end
    if k ~= k_caller then
        return res
    end
end

local function combinations(k, t)
    return coroutine.wrap(function() 
        return generator.combinations(k, t, k)
    end)
end

iterator.combinations = combinations

return iterator
