#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

data = {
    {131, 673, 234, 103, 18},
    {201, 96,  342, 965, 150},
    {630, 803, 746, 422, 111},
    {537, 699, 497, 121, 956},
    {805, 732, 524, 37,  331}
}

function step_gen(data)
    local step = function(x, y) 
       local nx, ny
       if x == #data[1] then
            nx, ny = x, y + 1
       end
       if y == #data[1] then
            nx, ny = x  + 1, y
       end
       if data[x + 1][y] < data[x][y + 1] then
            nx, ny = x + 1, y
       else
            nx, ny = x, y + 1     
       end
       return data[nx][ny], nx, ny
    end

    return step
end 


function problem81(data)
    local step = step_gen(data)
    local val, x, y = step(1, 1)
    print(val, x, y)
    repeat
        val, x, y = step(x, y)
        print(val, x, y)
    until not val
end

problem81(data)
