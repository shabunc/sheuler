#!/usr/bin/env ruby

LILTREE = [1, 3, -1, 2, 7, 0, -2] 

def extremum_sum(tree, n, &maxby)
    if not tree[n - 1] then
        return 0
    end
    rec = 
    tree[n - 1]  + yield(extremum_sum(tree, 2 * n, &maxby), extremum_sum(tree, 2 * n + 1, &maxby))
end

def max_sum(tree)
    extremum_sum(tree, 1) do |a, b| [a, b].max end
end

def min_sum(tree)
    extremum_sum(tree, 1) do |a, b| [a, b].min end
end

puts max_sum(LILTREE)
puts min_sum(LILTREE)
