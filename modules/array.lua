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

array.join = join
array.copy = copy
array.reduce = reduce
array.are_equal = are_equal
return array
