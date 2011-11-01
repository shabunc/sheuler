#!/usr/bin/env ruby

def root(n)
    Math.sqrt(n + 0.25) + 0.5
end

def problem100(min)
    found = {}
    j = 1
    while true do
        sq = j * j
        a = (j + 1) / 2
        if (sq - 1) % 4 == 0 then
            k = (sq - 1) / 4
            found[k] = a
            if found[k / 2] then
               puts "#{a}"
            end
        end
        j = j + 1
    end
end

problem100(10 ** 12)
