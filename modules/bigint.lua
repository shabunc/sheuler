require("array")
--shame on me)))
require("numeric")


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

function bigint:inc(n, from)
    local big = self:copy()
    local rem = n
    from = from  or #big.num
    local i = from
    while true do
        big.num[i], rem = inc(big.num[i], rem, big.base) 
        if rem == 0 then
            break
        end
        i = i - 1
        if i == 0 then
            table.insert(big.num, 1, 1)
            break
        end
    end
    return big
end

function bigint:copy()
    return bigint:new(array.copy(self.num), self.base)
end

function bigint:add(b) 
    local a = self:copy()
    if b:len() > a:len() then
        a, b = b, a
    end
    local i = b:len()
    local dlen = a:len() - b:len()
    local rem = 0
    while true do
        a[i + dlen], rem = inc(a[i + dlen], b[i] + rem, self.base)
        i = i - 1
        if i == 0 then
            if rem > 0 then
                table.insert(a.num, 1, rem)
            end
            break
        end
    end
    print(a)
end

function bigint:len()
    return #self.num
end

function bigint:times(n)
    local res = bigint:new(self.num, self.base)
    local m = numeric.digits2num(self.num)
    for j = 1, n - 1 do
        for k = 1, m do
            res = res:inc()
        end
    end
    return res
end

return bigint
