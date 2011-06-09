#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function nextdig(head, lim)
    local dig
    local prevnum
    for j = 0, 9 do
        local num = bignum(head)
        table.insert(num, j)
        local sq = num:mul(num)
        local test = array(sq, 1, #lim)
        if numeric.number(test) >= numeric.number(lim) then
            break
        end
        prevnum = num
    end
    return prevnum, prevnum[#prevnum]
end

function root(n, precision)
    local lim = array(numeric.digits(n))
    local head = array(numeric.digits(math.floor(math.sqrt(n))))
    local dig
    for j = 1, precision - #head do
       head, dig = nextdig(head, lim) 
    end
    return head
end

function problem80()
    local total = 0
    for j = 1, 100 do
        if j % math.sqrt(j) ~= 0 then
            local sq = root(j, 100)
            local sum = sq:reduce(function(a, b) return a + b end)
            total = total + sum
            print(sq, j, sum)
        end
    end
    print("TOTAL", total)
end

--[[
assert(tostring(root(2, 100)) == "4142135623730950488016887242096980785696718753769480731766797379907324784621070388503875343276415727")
]]
--ОШИБКА - см. на те последовательности где дофига девяток - они врут


problem80()
