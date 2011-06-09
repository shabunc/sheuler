require("array")

print("WARN! bigint is obsolete, use bignum!")

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
    --малоприятное известие, но, изменяя здесь, изменяй и mul_generator
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

function bigint:mul_generator(b)
    --!!! тут ничего не меняем, меняем в mul
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

function bigint:mul_iterator(b) 
    return coroutine.wrap(function() 
    end)
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
    if n == 0 then
        return bigint:new{1}
    end 
    if n == 1 then
        return self:copy()
    end
    local a = self:copy()
    local b = a:pow((n - n % 2)/2)
    b = b:mul(b)
    res = b:mul(a:pow(n % 2))
    return res 
end

function bigint:in_base(n) 
    local res = bigint:new({0}, n)
    local base = bigint:new(numeric.num2digits(self.base), n)
    for j = self:len() - 1, 0, -1 do
        res = res:add(base:pow(j):mul(bigint:new({self[self:len() - j]}, n)))
    end
    return res
end

function bigint:revert(n)
    local rev = {}
    for j = self:len(), 1, -1 do
        table.insert(rev, self.num[j])
    end
    local res = bigint:new(rev, self.base)
    return res
end

return bigint
