#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

LILGRAPH = {
    [1] = {{2, 16}, {3, 12}, {4, 21}},
    [2] = {{1, 16}, {4, 17}, {5, 20}},
    [3] = {{1, 12}, {4, 28}, {6, 31}},
    [4] = {{1, 21}, {2, 17}, {3, 28}, {5, 18}, {6, 19}, {7, 23}},
    [5] = {{2, 20}, {4, 18}, {7, 11}},
    [6] = {{3, 31}, {4, 19}, {7, 27}},
    [7] = {{4, 23}, {5, 11}, {6, 27}}
}

function find(vertices, vertice)
    for  _, vert in ipairs(vertices) do
        if vertices == vert then
            return true
        end
    end
    return false
end

function describe(graph)
    for v, edges in pairs(graph) do
        io.write(v, " => ")
        for _, edge in ipairs(edges) do
            io.write(edge[1], " ")
        end
        print(" ")
    end
end

function minimum(graph, verts, sptree) 
    local a, b
    local v = math.huge
    for _, vert in ipairs(verts) do
        local neighs = graph[vert]
        for _, edge in ipairs(neighs) do
            if edge[2] < v and not (sptree[edge[1]] and sptree[vert]) then
                a = vert
                b = edge[1]
                v = edge[2]
            end
        end
    end
    if not sptree[a] then
        sptree[a] = {}
    end
    table.insert(sptree[a] , {b, v})
    if not sptree[b] then
        sptree[b] = {}
    end
    table.insert(sptree[b] , {a, v})
    table.insert(verts, b)
    return verts, sptree, v
end

function problem107(graph)
    local sptree = {}
    local verts = {1}
    local sum = 0
    for j = 1, #graph - 1 do
        verts, sptree, val  = minimum(graph, verts, sptree)
        sum = sum + val
    end
    describe(sptree)
    print("SUM ", sum)
end

problem107(LILGRAPH)

