#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function step(n, m, rem, len)
    if len == 0 then
        return
    end
    local rem = 0
    for m = 1, 9 do
        local pr = n * m + rem
        local r = pr % 10
        if r == rem + m then
        end
    end
end


step(5, 0, 2)
