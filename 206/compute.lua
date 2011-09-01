#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")

function explore()
    local j = 430 
    local incs = {40, 60}
    local incs = {100, 300, 840, 300, 100, 860}
    local i = -1
    local prev = j
    while true do
        local n = j * j
        local digs = numeric.digits(n)
        if digs[#digs - 6] and digs[#digs - 6] == 7 then
            if digs[#digs - 8] and digs[#digs - 8] == 6 then
                if digs[#digs - 10] and digs[#digs - 10] == 5 then
                    if digs[#digs - 12] and digs[#digs - 12] == 4 then
                        if digs[#digs - 14] and digs[#digs - 14] == 3 then
                            if digs[#digs - 16] and digs[#digs - 16] == 2 then
                                print(j, table.concat(digs, ""), j - prev)
                                prev = j
                            end
                        end
                    end
                end
            end
        end
        i = (i + 1) % #incs
        local step = incs[i + 1]
        j = j + step
    end
end

explore()
