#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("array")

function lazy(f, cur)
    local res = {}
    local current 
    local step = 1
    res.inspect = function() 
        return current
    end
    res.move = function() 
        current = f(step)
        step  = step + 1
        return res
    end
    return res.move()
end

function ham(n, lt)
    return lazy(function() 
        return n * lt.inspect()
    end)
end


function merge(la, lb)
    local function movefunc()
        local a = la.inspect()
        local b = lb.inspect()
        local res
        if a == b then
            res = a
            la.move()
            lb.move()
        elseif a < b then
            res = a
            la.move()
        else
            res = b
            lb.move()
        end
        return res
    end
    return lazy(movefunc)
end


local h = hamming()
for j = 1, 10 do
    print(h.inspect())
    h.move()
end
