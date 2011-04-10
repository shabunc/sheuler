#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("permutations")

function problem41(t)
    local iterator = perm.lexicographic_iterator(t, perm.prev_lexicographic)
    while true do
        local permutation = iterator()
        if not permutation then 
            break
        end
        local num = numeric.digits2num(permutation)
        local divisors, is_prime = numeric.divisors(num)
        if is_prime then
            print(num, is_prime)
            return num
        end
    end
end

t = problem41({7,6,5,4,3,2,1})
