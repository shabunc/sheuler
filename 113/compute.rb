#!/usr/bin/env ruby

def memoize(name) 
    cache = {}
    (class << self; self; end).send(:define_method, name) do |*args|
        unless cache.has_key? args 
            cache[args] = super *args
        end
        cache[args]
    end
    cache
end

def bd(n, k)
    if n == 1 then
        return k + 1
    end
    (0..k).to_a.inject(0) do |sum, j| sum += bd(n - 1, j) end
end

def f(n)
    inc = bd(n, 8)
    dev = bd(n, 9) 
    inc + dev - 10
end

def ff(n)
    (1..n).to_a.map do |k| f(k) end 
    .inject(:+)
end

memoize(:bd)

raise "caramba!" if not ff(6) == 12951
raise "caramba!" if not ff(10) == 277032

p ff(ARGV[0].to_i)

