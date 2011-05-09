#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("data")

function slice(data, i, j, move_func, stop_func)
    local a, b = i, j 
    local res = {}
    while true do
        table.insert(res, data[a][b])
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
    return a - 1, b
end

function down(a, b)
    return a + 1, b
end

function downright(a, b)
    a, b = down(a, b)
    return right(a, b)
end

function downleft(a, b)
    a, b = down(a, b)
    return left(a, b)
end

--хорошее название))
function biggest_down(data)
    local max = -1
    local n, m  = #DATA, #DATA[1]
    for j = 1, n - 4 do
        for i = 1, m  do
            local res = slice(data, j, i, down, limit4)
            local pr = array.reduce(res, function(a, b) return a*b end, 1)
            if pr > max then
                max = pr
            end
        end
    end
    print("MAX DOWN", max)
    return max
end

function biggest_right(data)
    local max = -1
    local n, m  = #DATA, #DATA[1]
    for j = 1, n do
        for i = 1, m - 4 do
            local res = slice(data, j, i, right, limit4)
            local pr = array.reduce(res, function(a, b) return a*b end, 1)
            if pr > max then
                max = pr
            end
        end
    end
    print("MAX RIGHT", max)
    return max
end

function biggest_downright(data)
    local max = -1
    local n, m  = #DATA, #DATA[1]
    for j = 1, n - 4 do
        for i = 1, m - 4 do
            local res = slice(data, j, i, downright, limit4)
            local pr = array.reduce(res, function(a, b) return a*b end, 1)
            if pr > max then
                max = pr
            end
        end
    end
    print("MAX DOWNRIGHT", max)
    return max
end

function biggest_downleft(data)
    local max = -1
    local n, m  = #DATA, #DATA[1]
    for j = 1, n - 4 do
        for i = 4, m do
            local res = slice(data, j, i, downleft, limit4)
            local pr = array.reduce(res, function(a, b) return a*b end, 1)
            if pr > max then
                max = pr
            end
        end
    end
    print("MAX DOWNLEFT", max)
    return max
end

function biggest(data)
    local res = math.max(biggest_right(data), biggest_down(data), biggest_downright(data), biggest_downleft(data))
    print("BIGGEST", res)
    return res
end

biggest(DATA)


