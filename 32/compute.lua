#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")


function pand_products(t, k, k_caller) 
   if k == 0 then
        return {{}}
   end  
   local res = {}
   for i, head in ipairs(t) do
        local tail = array.copy(t)
        table.remove(tail, i)
        local prods = pand_products(tail, k - 1, k_caller)
        for _, prod in ipairs(prods) do
            table.insert(prod, 1, head)
            table.insert(res, prod)
            if k == k_caller then
                coroutine.yield(prod, i, head)
            end
        end
   end
   if k ~= k_caller then
       return res
   end
end

function pand(t) 
    return coroutine.wrap(function() return pand_products(t,#t,#t) end)
end

next_prod = pand({1,2,3,4,5,6,7,8,9})
local res = {}
while true do
    local pand = next_prod()
    if not pand then
        break
    end
    for mul = 1, #pand - 2 do
        for eq = mul + 1, #pand -1 do
            local a = {}
            local b = {}
            local c = {}
            for j = 1, #pand do
                if j <= mul then
                    table.insert(a, pand[j])
                elseif j <= eq then 
                    table.insert(b, pand[j])
                else
                    table.insert(c, pand[j])
                end
            end
            an = numeric.digits2num(a)
            bn = numeric.digits2num(b)
            cn = numeric.digits2num(c)
            if an * bn == cn then
                --print(an, '*', bn, '=', cn)
                res[cn] = 1
            end
        end
    end
end
local total = 0
for k, v in pairs(res) do
    total = total + k
    print(k)
end
print("===")
print(total)
