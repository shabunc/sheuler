require("array")
bignum = array:new()

function bignum:init(t, base)
    array.init(self, t)
    self.base = base or 10
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

function bignum:copy() 
    return bignum(self, self.base)
end

function bignum:add(b) 
    local a = self:copy()
    if #b > #a then
        a, b = b, a
    end
    local i = #a
    local dlen = #a - #b
    local rem = 0
    while true do
        a[i], rem = inc(a[i], (b[i - dlen] or 0) + rem, self.base)
        i = i - 1
        if i == 0 then
            if rem > 0 then
                table.insert(a, 1, rem)
            end
            break
        end
    end
    return a
end

function bignum:mul(b)
    local a = self:copy()
    if #b > #a then
        a, b = b, a
    end
    local res = bignum{0}
    for i = #b, 1, -1 do
        local row = a:copy()
        local j = #row
        local rem = 0
        local rem_prev = 0
        while true do
            row[j], rem = mul(row[j], b[i], self.base)
            row[j], rem_prev  = inc(row[j], rem_prev, self.base)
            rem_prev = rem + rem_prev
            j = j - 1
            if j == 0 then
                if rem_prev > 0 then
                    table.insert(row, 1, rem_prev)
                end
                break
            end
        end
        for k = 1, #b - i do
            table.insert(row, 0)
        end
        res = row:add(res)
    end
    return res
end

function bignum.compare(a, b)
    if #a > #b then
        return 1
    elseif #a < #b then
        return  -1
    end
    for i = 1, #a do
        if a[i] > b[i] then
            return 1
        elseif a[i] < b[i] then
            return -1
        end
    end
    return 0
end

function bignum:pow(n) 
    if n == 0 then
        return bignum{1}
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
