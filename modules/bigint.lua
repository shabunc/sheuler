require("array")


local function __tostring(self)
    return table.concat(self.num)
end

local function bigint_new(num, base)
    local res = {}
    res.num = num
    res.base = base or 10
    local mt = {
        __index = function(self, k)
            if type(k) == "string" then
                return rawget(bigint, k)
            elseif type(k) == "number" then
                return self.num[k]
            end
        end,
        __newindex = function(self, k, v)
            if type(k) == "number" then
                self.num[k] = v
            end
        end,
        __tostring = __tostring
    }
    setmetatable(res, mt)
    return res
end

bigint = {}

function bigint:new(num, base) 
    return bigint_new(num, base)
end

local function inc(digit, n, base)
    base = base or 10
    if (digit + n) >= base then
        return (digit + n - base), 1
    else
        return (digit + n), 0
    end
end

local function mul(digit, n, base)
    base = base or 10
    local res = digit * n
    local rem = math.floor(res / base)
    return res - rem * base, rem
end

function bigint:copy()
    return bigint:new(array.copy(self.num), self.base)
end

function bigint:add(b) 
    local a = self:copy()
    if b:len() > a:len() then
        a, b = b, a
    end
    local i = a:len()
    local dlen = a:len() - b:len()
    local rem = 0
    while true do
        a[i], rem = inc(a[i], (b[i - dlen] or 0) + rem, self.base)
        i = i - 1
        if i == 0 then
            if rem > 0 then
                table.insert(a.num, 1, rem)
            end
            break
        end
    end
    return a
end

function bigint:len()
    return #self.num
end

function bigint:mul(b)
    local a = self:copy()
    if b:len() > a:len() then
        a, b = b, a
    end
    local res = bigint:new{0}
    for i = b:len(), 1, -1 do
        local row = a:copy()
        local j = row:len()
        local rem = 0
        local rem_prev = 0
        while true do
            row[j], rem = mul(row[j], b[i], self.base)
            row[j], rem_prev  = inc(row[j], rem_prev, self.base)
            rem_prev = rem + rem_prev
            j = j - 1
            if j == 0 then
                if rem_prev > 0 then
                    table.insert(row.num, 1, rem_prev)
                end
                break
            end
        end
        for k = 1, b:len() - i do
            table.insert(row.num, 0)
        end
        res = row:add(res)
    end
    return res
end

function bigint:times(n)
    --shame on me )))
    local res = self:copy()
    for j = 1, n - 1 do
        res = res:add(self)
    end
    return res
end

function bigint:pow(n) 
    local a = self:copy()
    local res = a:copy()
    for j = 1, n - 1 do
        res = res:mul(a)
    end
    return res
end

return bigint
