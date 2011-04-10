#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("permutations")

function has_magic_property(permutation)
    local primes = {2, 3, 5, 7, 11, 13, 17}
    for j = 2, #permutation - 2 do
        local num = 100 * permutation[j] + 10 * permutation[j + 1] + permutation[j + 2]
        if num % primes[j - 1] ~= 0 then
            return false
        end
    end
    return true
end

function find_all_magic() 
    local iterator = perm.lexicographic_iterator({0,1,2,3,4,5,6,7,8,9})
    local res = {}
    local sum = 0
    while true do
        local permutation = iterator()
        if not permutation then
            break
        end
        if has_magic_property(permutation) then
            local num = numeric.digits2num(permutation)
            sum = sum + num
            res[#res + 1] = permutation
        end
    end
    print(sum)
    return res
end

function problem41() 
    all = find_all_magic()
end

problem41()
