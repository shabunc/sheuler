#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("iterator")


function problem172()
    local it = iterator.partitions(18, {1,2,3})
    while true do
        local seq = it()
        if not seq then
            break
        end
    end
end

problem172(18)
