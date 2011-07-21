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

def divisors(n)
    res = []
    (1 .. n ** 0.5).each do|d|
        if n % d == 0 then
            res << d
            if d != n / d then
                res << n / d
            end
        end
    end
    res.sort
end

def problem104()
    n = 100
    divs = []
    while true do
        f = fib(n)
        if pref_pan(f) then
            divs = divs + divisors(n)
            divs.sort!.uniq!
            p n, divs
        end
        n = n + 1
    end
end

problem104()
