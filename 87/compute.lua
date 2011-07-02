#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("iterator")

function func(a, b, c) 
    return numeric.prime(a)^2 + numeric.prime(b)^3 +numeric.prime(c)^4
end

function find_largest(max, func)
    for n = 3, math.huge do
        if (numeric.prime(n) ^ 2) > max then
            return n
        end
    end
end

function generator(max, ...) 
end

function find_all(max)
    local found = {}
    local total = 0
    for j = 1, math.huge do
        local jp = numeric.prime(j)
        for i = j, 1, -1 do
            for k = i, 1, -1 do
                local jp, ip, kp = numeric.prime(j), numeric.prime(i), numeric.prime(k)
                if jp^2 > max - 24 then
                    return total
                end
                local it = iterator.perm_lex({kp, ip, jp})
                while true do
                    local seq = it()
                    if not seq then
                        break
                    end
                    local a, b, c = unpack(seq)
                    local val = a^2 + b^3 + c^4
                    if val < max then
                        if not found[val] then
                            found[val] = true
                            total = total + 1
                            print(a, b, c, "=>", val, " => ", total)
                        end
                    end
                end
            end
        end
    end
    return total
end

assert(find_all(50) == 4)
find_all(50 * 10^6)
