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

local function copy(a) 
    local res = {}
    for j in ipairs(t) do
        res[j] = t[j]
    end
    return res
end

array.join = join
array.copy = copy
return array
