#!/usr/bin/env ruby
#
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
memoize(:part)

def problem78(div)
    j = 1
    while true do
        pt = part(j)
        if pt % div == 0 then
            puts j, pt
            return
        end
        j = j + 1
    end
end

problem78(1000000)
