#!/usr/bin/env ruby

def pow(n) 
    if n == 0 then
        return 0, 1
    end
    if n % 2 == 0 then
        a, b = pow(n / 2) 
        return 2 * a * b - a ** 2, a ** 2 + b ** 2
    else
        a, b = pow(n - 1)
        return b, a + b
    end
end

def pref_pan(n)
    digs = n.to_s.chars.to_a
    digs[0..8].sort == ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
end

def post_pan(n)
    digs = n.to_s.chars.to_a
    digs[digs.length - 9, digs.length].sort == ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
end

def fib(n)
    _, res = pow(n)
    res
end

n = 100
while true do
    f = fib(n)
    p (n)
    if post_pan(f) and pref_pan(f) then
        p n, f
        break
    end
    n = n + 1
end
