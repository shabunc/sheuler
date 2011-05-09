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

local serialize_partition = function(t)
    local s = ""
    for i, v in ipairs(t) do
        s = s  .. v[1] .. "*" .. v[2] .. " "
    end
    return s
end

generator.partitions = function(n, t, from, inner)
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
        local ps = generator.partitions(n - t[from] * j, t, from + 1, true)
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

local function partitions(n, t)
    return coroutine.wrap(function() return generator.partitions(n, t, 1) end)
end

local function get_all(iterator)
    local res = {}
    while true do
        local seq = iterator()

        if not seq then
            break
        end
        table.insert(res, seq)
    end
    return res
end

iterator.combinations = combinations
iterator.partitions = partitions
iterator.get_all = get_all

return iterator
