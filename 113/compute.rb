#!/usr/bin/env ruby

def bi(n, k)
    if n == 1 then
        return  10 - k
    end
    (k..9).to_a.inject(0) do |sum, j| sum += bi(n - 1, j)  end
end

def bd(n, k)
    if n == 1 then
        return k + 1
    end
    (0..k).to_a.inject(0) do |sum, j| sum += bi(n - 1, j) end
end

def f(n)
    inc = bi(n, 1)
    dev = bd(n, 9) 
    inc + dev - 10
end

def ff(n)
    (1..n).to_a.map do |k| f(k) end 
    .inject(:+)
end

raise "caramba!" if not ff(6) == 12951
raise "caramba!" if not ff(10) == 277032

p ff(ARGV[0].to_i)
