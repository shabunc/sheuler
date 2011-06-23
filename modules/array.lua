require("class")

array = class:new(table)
function array:init(t, from, to)
    from = from or 1
    to = to or #t
    for j = from, to do
        table.insert(self, t[j])
    end
end

function array.range(from, to)
    local res = array{}
    for j = from, to do
        table.insert(res, j)
    end
    return res
end

function array:reduce(reduce_func, initial_value)
    local res = initial_value or 0
    for i, v in ipairs(self) do
        res = reduce_func(res, v)
    end
    return res
end

function array:sub(from, to)
    local res  = array{}
    for j = from, to do
        table.insert(res, self[j])
    end     
    return res
end

function array:map(map_func)
    local res = array:new({})
    for i, v in ipairs(self) do
        table.insert(res, map_func(v, i))
    end
    return res
end

function array:filter(filter_func)
    local res = array:new({})
    for i, v in ipairs(self) do
        if filter_func(v, i) then
            table.insert(res, v)
        end
    end
    return res
end

function array:every(every_func) 
    for i, v in ipairs(self) do
        if not every_func(v, i) then
            return false
        end
    end
    return true
end

function array:any(any_func) 
    for i, v in ipairs(self) do
        if any_func(v, i) then
            return true
        end
    end
    return false
end

function array.zipWith(zip_func, a, b)
    local l = math.min(#a, #b)
    local res = {}
    for j = 1, l do
        table.insert(res, zip_func(a[j], b[j], a, b, j))
    end
    return res
end

function array:index_of(el) 
    local filter = function(i, v) return v == el end
    if type(el) == "function" then
        filter = function(i, v) return el(i, v) end
    end
    for j = 1, #self do
        if filter(j, self[j]) then
            return j
        end
    end
    return 0
end

function array:uniq()
    if #self == 0 then
        return {}
    end
    local copy = array(self)
    table.sort(copy)
    local res = array{copy[1]}
    for j = 2,  #copy do
        if copy[j] ~= copy[j - 1] then
            table.insert(res, copy[j])
        end
    end
    return res
end

function array:reverse()
    local res = array{}
    for j = #self, 1, -1 do
        table.insert(res, self[j])
    end
    return res
end

function array:__eq(b)
    if #self ~= #b then
        return false
    end
    for i in ipairs(self) do
       if self[i] ~= b[i] then
            return false
       end
    end
    return true
end

function array:__tostring()
    return table.concat(self)
end

function array:remove(...)
    return table.remove(self, ...)
end

function array:insert(...)
    table.insert(self, ...)
    return self, #self
end

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

local function are_permutations(a, b)
    local sa = array.copy(a)
    local sb = array.copy(b)
    table.sort(sa)
    table.sort(sb)
    return are_equal(sa, sb)
end

local function insert_sorted(a, n)
    if #a == 0 then
        a[1] = n
        return a
    end
    if n < a[1] then
        table.insert(a, 1, n)
        return 1
    end
    for j = 1, #a do
        if n > a[j] and (j == #a or n < a[j+1]) then
            table.insert(a, j + 1, n)
            return j + 1 
        end
    end
end

array.join = join
array.insert_sorted = insert_sorted
return array
