#!/usr/bin/env ruby

def is_square(n)
    sq = n ** 0.5
    sq.floor() == sq.ceil()
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
                x = (x2 ** 0.5).to_i
                if x > max then
                    max = x
                    md = d
                end
                check = x * x - d * y * y
                puts "#{d} #{x} #{y} => #{check}"
                break
            end
        end
    end
    print "MAX #{max} #{md}"
    max
end

problem66(62)
