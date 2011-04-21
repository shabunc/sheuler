#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function stat_for_seq(t)
    local res = {
       [-1] = 0, [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0
    }
    local prev = -1
    local candidate = 0
    for j = 1, #t do
        if t[j] == prev then
            candidate = candidate + 1
        else
            if res[prev] < candidate then
                res[prev] = candidate
            end
            candidate = 1
        end
        prev = t[j]
    end
    if res[t[#t]] < candidate then
        res[t[#t]] = candidate
    end
    return res
end

