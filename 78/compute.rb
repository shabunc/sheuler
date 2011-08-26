#!/usr/bin/env ruby

def penta1(q)
    q * (3 * q - 1) / 2
end

def penta2(q)
    q * (3 * q + 1) / 2
end

def part(n)
    if n < 0 then
        return 0
    end
    if n == 0 or n == 1 then
        return 1
    end
    sum = 0
    j = 1
    while true do
        k1 = penta1(j)
        k2 = penta2(j)
        pair = part(n - k1) + part(n - k2)
        if pair == 0 then
            return sum
        end
        if j % 2 == 0 then
            pair = -pair
        end
        sum = sum + pair
        j = j + 1
    end
end

puts(part(10))
