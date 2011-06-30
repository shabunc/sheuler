#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function add_left(tree, child)
    tree.left = child
end

function add_right(tree, child)
    tree.right = child
end

function tree(val, left, right) 
    local root = {}
    root.val = val
    add_left(root, left)
    add_right(root, right)
end


function layer(nodes, vals)
    local subnodes = {}
    for _, v in ipairs(vals) do
        table.insert(subnodes, vals[v])
    end
    add_left(nodes[1], vals[1])
    add_right(nodes[1], vals[2])
end

local ROOT = {}
layer(ROOT, 
