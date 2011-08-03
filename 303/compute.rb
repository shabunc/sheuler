#!/usr/bin/env ruby

def digits(n)
    res = []
    len = Math.log10(n).floor
    (0 .. len).reverse_each do |j|
        dig = n / (10 ** j)
        res << dig
        n = n - dig  * (10 ** j)
    end
    res
end

def f(n)
    (1..(1.0/0)).each do |j|
        m = j * n
        digs = digits(m)
        puts(j, m)
        if digs.all? {|x| x < 3} then
            return m, j
        end
    end
end

def ff(n)
    sum = 0
    (1 .. n).each do |j|
        res = f(j)[0]
        puts(j, res)
        sum = sum + res
    end
    sum
end

puts ff(100)
