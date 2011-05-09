require("array")
print("OBSOLETE, USE iterator.permuations")

perm = {}

local metas = {
    simple_string = {
        __tostring = function(t) 
            return table.concat(t)
        end
    }
}

local function next_lexicographic(permutation)
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
    return next_lexicographic(permutation)
end

local function prev_lexicographic(permutation)
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
    return prev_lexicographic(permutation)
end

local function lexicographic_iterator(t, iterate_func) 
    iterate_func = iterate_func or next_lexicographic
    local iterator = coroutine.wrap(function() return iterate_func(t) end)
    return iterator
end

local function permutations_generator(t, inner) 
    if #t == 0 then
        return {{}}
    end
    local res = {}
    for j = 1, #t do
        local tail = array(t)
        local head = table.remove(tail, j)
        local recs = permutations_generator(tail, true)
        for _, p in ipairs(recs) do
            table.insert(p, 1, head)
            table.insert(res, p)
            if not inner then
                coroutine.yield(p)
            end
        end
    end
    if inner then
        return res
    end
end

local function permutations_iterator(t)
    return coroutine.wrap(function() return permutations_generator(t) end)
end

perm.next_lexicographic = next_lexicographic
perm.prev_lexicographic = prev_lexicographic
perm.lexicographic_iterator = lexicographic_iterator
perm.iterator = permutations_iterator
return perm
