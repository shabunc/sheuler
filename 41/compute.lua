#!/usr/bin/env lua
package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("permutations")

function problem41(t)
    local iterator = perm.lexicographic_iterator(t)
    local res = {}
    while true do
        local permutation = iterator()
        if not permutation then 
            break
        end
        local num = numeric.digits2num(permutation)
        local divisors, is_prime = numeric.divisors(num)
        print(num)
        if is_prime then
            table.insert(res, num)
            print(num, is_prime)
        end
    end
    return res
end

t = problem41({1,2,3,4,5,6,7,8,9})
print(table.concat(t, " "))
