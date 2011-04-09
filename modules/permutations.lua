perm = {}

local function next_lexicographic(permutation)
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

local function lexicographic_iterator(t) 
    local iterator = coroutine.wrap(function() return next_lexicographic(t) end)
    return iterator
end

perm.next_lexicographic = next_lexicographic
perm.lexicographic_iterator = lexicographic_iterator
return perm
