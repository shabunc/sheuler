#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("data")

function slice(i, j, move_func, stop_func)
    local a, b = i, j 
    local res = {}
    while true do
        table.insert(res[a][b])
        a, b = move_func(a, b)
        if stop_func(res) then
            break
        end
    end
    return res
end

function limit4(res)
    return #res == 4
end

function right(a, b)
    return a, b + 1
end

function left(a, b)
    return a, b - 1
end

function up(a, b) 
    return a + 1, b
end

function down(a, b)
    return a - 1, b
end

function downright(a, b)
    a, b = down(a, b)
    return right(a, b)
end

function downleft(a, b)
    a, b = down(a, b)
    return left(a, b)
end

