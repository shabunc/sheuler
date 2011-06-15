#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function findcubes(max)
    print("fetching cubes")
    local res = {}
    for j = 1, max do
        res[j*j*j] = j
    end 
    print("done")
    return res
end
MAX = 10^6
CUBES = findcubes(MAX)

function is_cube(n)
    return CUBES[n]
end
    
function hypo(n) 
    total = 0
    for j = 1, n do 
        local phi2 = j * numeric.totient(j)
        if is_cube(phi2) then
            total = total + j
            print(j, phi2, is_cube(phi2))
        end
    end
    print("TOTAL", total)
    return total
end

hypo(MAX)
