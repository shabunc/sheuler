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
        __index = bigint,
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

function bigint:inc(n)
    local rem = n
    local i = #self.num
    while true do
        self.num[i], rem = inc(self.num[i], rem, self.base) 
        if rem == 0 then
            break
        end
        i = i - 1
        if i == 0 then
            table.insert(self.num, 1, 1)
            break
        end
    end
    return self
end

--[[
function bigint:inc()
    local base = self.base or 10
    local res = array.copy(self.num)
    local max_digit = base - 1
    local i = #res - 1
    if res[#res] ~= max_digit then
        res[#res] = res[#res] + 1
    else
        res[#res] = 0
        while res[i] == max_digit do
            res[i] = 0
            i = i - 1
        end
        if i == 0 then
            table.insert(res, 1, 1)
        else
            res[i] = res[i] + 1
        end
    end
    return bigint:new(res, base)
end
]]

function bigint:add(n)
    local res = bigint:new(self.num, self.base)
    for j = 1, n do
        res = res:inc()
    end
    return res
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
