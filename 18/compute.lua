#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")

function add_left(root, lval)
    root.left = tree(lval)
end

function add_right(root, rval)
    root.right = tree(rval)
end

function tree(val)
    local root = {}
    root.val = val
    return root
end


function layer(nodes, vals)
    add_left(nodes[1], vals[1])
    local subnodes = {nodes[1].left}
    for j = 1, #nodes do
        add_right(nodes[j], vals[j + 1])
        table.insert(subnodes, nodes[j].right)
    end
    return subnodes
end

function maketree(vals) 
    local root = tree(vals[1])
    local subs = {root}
    local count = 2
    while count < (#vals + 1) do
        add_left(subs[1], vals[count])
        for j = 1, #subs do
            add_right(subs[j], vals[count] + 1
        end
    end
    return root
end

local ROOT = maketree({3, 7, 4})
print(ROOT.left)
