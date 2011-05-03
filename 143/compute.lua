#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function triangle120(a, b)
    local c = math.sqrt(a*a + b*b + a*b)
    return math.floor(c) == c, c
end

function problem148(maxlen)
    local total = 0
    local sum = 0
    for p = maxlen, 1, -1 do
        for q = p, 1, -1 do
            local is_integer, a = triangle120(p, q)
            if is_integer then
                print("hm", p)
                for r = q, 1, -1 do
                    local is_integer, b = triangle120(q, r)
                    if is_integer then
                        local is_integer, c = triangle120(p, r)
                        if is_integer then
                            local s = p + q + r
                            if s <= maxlen then
                                print(a, b, c, s)
                                total = total + 1
                                sum = sum + s
                            end
                        end
                    end
                end
            end
        end
    end
    print("TOTAL", total)
    print("SUM", sum)
    return total, sum
end

problem148(120000)
