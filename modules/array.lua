array = {}

local function join(a, b) 
    while true do
        local el = table.remove(b,1)
        if not el then
            break
        end
        table.insert(a, el)
    end
    return a
end

local function copy(t) 
    local res = {}
    for j in ipairs(t) do
        res[j] = t[j]
    end
    return res
end

local function reduce(a, reduce_func, initial_value)
    local res = initial_value or 0
    for i, v in ipairs(a) do
        res = reduce_func(res, v)
    end
    return res
end

local function map(a, map_func) 
    local res = {}
    for i, v in ipairs(a) do
        table.insert(res, map_func(v, i))
    end
    return res
end

local function are_equal(a, b)
    if #a ~= #b then
        return false
    end
    for i in ipairs(a) do
       if a[i] ~= b[i] then
            return false
       end
    end
    return true
end

local function are_permutations(a, b)
    local sa = array.copy(a)
    local sb = array.copy(b)
    table.sort(sa)
    table.sort(sb)
    return are_equal(sa, sb)
end

local function sub(a, from, to)
    to = to or #a
    local res = {}
    for j = from, to do
        table.insert(res, a[j])
    end
    return res
end

array.join = join
array.copy = copy
array.map = map
array.reduce = reduce
array.are_equal = are_equal
array.are_permutations = are_permutations
array.sub = sub
return array
