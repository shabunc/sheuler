#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function quasifib(n) 
    if n == 0 then
        return {1}
    end
    local prev = quasifib(n - 1)
    local from = prev[#prev] + 2*n 
    local res = {}
    for j = 0, 3 do
        table.insert(res, j * 2 * n + from)
    end
    return res
end

function problem28(n)
    local sum = 0
    for j = 0, n do
        sum = sum + array.reduce(quasifib(j), function(a, b) return a + b end)
    end
    print("SUM", sum)
    return sum
end

print(table.concat(quasifib(0)))
print(table.concat(quasifib(1)," "))
print(table.concat(quasifib(2)," "))
print(table.concat(quasifib(3)," "))

problem28(500)

