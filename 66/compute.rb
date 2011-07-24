#!/usr/bin/env ruby

def is_square(n)
    sq = Math.sqrt(n).floor
    sq * sq == n
end

def problem66(maxD)
    max = -1
    md = -1
    (1..maxD).each do |d|
        if is_square(d) then
            next
        end
        (1 .. 1.0/0).each do |y|
            x2 = d * y * y + 1
            if is_square(x2) then
                x = Math.sqrt(x2).to_i
                if x > max then
                    max = x
                    md = d
                end
                check = x * x - d * y * y
                check = x2 - d * y * y
                puts "#{d} #{x} (#{x*x} #{x2}) #{y} => #{check} "
                break
            end
        end
    end
    puts "MAX #{max} #{md}"
    max
end

problem66(1000)
