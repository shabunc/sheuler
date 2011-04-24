#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bigint")

function is_reversible(big)
    if big[big:len()] == 0 then
        return false
    end
    local test = big:add(big:revert())
    local res = true
    for j = 1, test:len() do
        if test[j] % 2 == 0 then
            res = false
            break
        end
    end
    return res
end 

local function inc(digit, n, base)
    base = base or 10
    if (digit + n) >= base then
        return (digit + n - base), 1
    else
        return (digit + n), 0
    end
end

function bigint:is_reversible()
    if self[self:len()] == 0 then
        return false
    end
    local a = self:copy()
    local b = self:copy()
    local i = a:len()
    local rem = 0
    while true do
        a[i], rem = inc(a[i], b[b:len() - i + 1] + rem, self.base)
        if a[i] % 2 == 0 then
            return false
        end
        i = i - 1
        if i == 0 then
            if rem > 0 then
                if rem % 2 == 0 then
                    return false
                end
                table.insert(a.num, 1, rem)
            end
            break
        end
    end
    return a
end

function problem145(len)
    local total  = 0
    local big = bigint:new{1} 
    while big:len() < len do
        local test = big:is_reversible()
        if test then
            print(big)
            total = total + 1
        end
        big = big:add(bigint:new{1})
    end
    print("TOTAL", total)
    return total
end

assert(problem145(4) == 120)
problem145(7)
