#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function tree(val, left, right) 
    local root = {}
    root.val = val
    root.left = left
    root.right = right
    return root
end

