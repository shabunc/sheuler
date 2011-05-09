require("array")

iterator = {}

local generator = {}


generator.combinations = function(k, t, from) 
    local caller = generator.combinations
    local inner = from ~= 1
    if k == 0 then
        return {{}}
    end
    local res = {}
    for i = from, #t do
        local head = t[i]
        local recs = caller(k - 1, t, i + 1)
        for j, rec in ipairs(recs) do
            table.insert(rec, 1, head)
            table.insert(res, rec)
            if not inner then
                coroutine.yield(rec)
            end
        end
    end
    if inner then
        return res
    end
end

local function combinations(k, t)
    return coroutine.wrap(function() 
        return generator.combinations(k, t, 1)
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

local metas = {
    simple_string = {
        __tostring = function(t) 
            return table.concat(t)
        end
    }
}

generator.permutations = {}
generator.permutations.next_lex = function(permutation)
    setmetatable(permutation, metas.simple_string)
    coroutine.yield(permutation)
    local k, l
    for j = 1, #permutation - 1 do 
        if permutation[j] < permutation[j+1] then
            k = j
        end
    end
    if not k then
        return false
    end
    for j = k + 1, #permutation do
        if permutation[j] > permutation[k] then
            l = j
        end
    end
    permutation[k], permutation[l] = permutation[l], permutation[k]
    local reverted = {}
    for j = #permutation, k + 1, -1  do
        reverted[#reverted + 1] = table.remove(permutation)
    end
    for j = 1, #reverted do
        table.insert(permutation, reverted[j])
    end
    return generator.permutations.next_lex(permutation)
end
generator.permutations.prev_lex = function(permutation)
    setmetatable(permutation, metas.simple_string)
    coroutine.yield(permutation)
    local k, l
    for j = 1, #permutation - 1 do 
        if permutation[j] > permutation[j+1] then
            k = j
        end
    end
    if not k then
        return false
    end
    for j = k + 1, #permutation do
        if permutation[j] < permutation[k] then
            l = j
        end
    end
    permutation[k], permutation[l] = permutation[l], permutation[k]
    local reverted = {}
    for j = #permutation, k + 1, -1  do
        reverted[#reverted + 1] = table.remove(permutation)
    end
    for j = 1, #reverted do
        table.insert(permutation, reverted[j])
    end
    return generator.permutations.prev_lex(permutation)
end

local function perm_lex(t, iterate_func)
    iterate_func = iterate_func or generator.permutations.next_lex
    local iterator = coroutine.wrap(function() return iterate_func(t) end)
    return iterator
end

generator.permutations.combinations = function(k, t, inner)
    local caller = generator.permutations.combinations
    local combos_it = iterator.combinations(k, t)
    while true do
        local combo = combos_it()
        if not combo then
            break
        end
        local perm_it = iterator.perm_lex(combo)
        while true do 
            local seq = perm_it()
            if not seq then
                break
            end
            coroutine.yield(seq)
        end
    end
end

local function perm_combinations(k, t)
    return coroutine.wrap(function() 
        return generator.permutations.combinations(k, t)
    end)
end

--в основном для тестирования
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
iterator.perm_lex = perm_lex
iterator.get_all = get_all

iterator.permutations = {}
iterator.permutations.combinations = perm_combinations


return iterator
