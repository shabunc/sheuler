#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function test(n) 
    local count = 0
    for a = 1, n do
        if n % a == 0 then
            local d = (n/a + a)
            if d % 4 == 0 then
                if d/4 < a then
                    if count == 1 then
                        return false
                    end
                    count = count + 1
                end
            end
        end
    end
    if count == 0 then
        return false
    end
    if count == 1 then
        return true
    end
end

function problem136(max)
    local total = 0
    for n = 1, max do
        if test(n) then
            total = total + 1
        end
    end
    return total
end

assert(problem136(100) == 25)

print("TOTAL", problem136(10^5))
