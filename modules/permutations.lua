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

perm.next_lexicographic = next_lexicographic
perm.prev_lexicographic = prev_lexicographic
perm.lexicographic_iterator = lexicographic_iterator
return perm
