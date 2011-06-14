#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function hypo(n) 
    for j = 1, n do 
        local phi2 = j * numeric.totient(j)
        for i = 2, n do
            if i * i * i == phi2 then
                print(j, phi2, i)
            end
        end
    end
end

hypo(10 ^ 5)
