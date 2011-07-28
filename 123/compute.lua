#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function remainder(n, a) 
    return 2 * n * a % a^2 
end

function brute(maxn)
    local maxa = math.huge
    for n = maxn-1000, maxn do
        for a = 1, maxa do
            local p = numeric.prime(a)
            local rem = remainder(n, p)
            if rem > 10^9 then
                maxa = a - 1
                print(n, p, rem)
                break
            end
        end
    end
end

function problem123(n)
    brute(8000, n, n)
end
    
brute(8000)
