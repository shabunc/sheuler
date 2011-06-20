#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function test(n) 
    local count = 0
    local divs = numeric.propers(n)
    for _, a in ipairs(divs) do
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
        print(n)
        if test(n) then
            total = total + 1
        end
    end
    return total
end

assert(problem136(100) == 25)

print("TOTAL", problem136(50 * 10^6))
