#!/usr/bin/env ruby

def is_square(n)
    sq = Math.sqrt(n).floor
    sq * sq == n
end

$max = -1

def problem66(from, to)
    md = -1
    (from..to).each do |d|
        if is_square(d) then
            next
        end
        (1 .. 1.0/0).each do |y|
            x2 = d * y * y + 1
            if is_square(x2) then
                x = Math.sqrt(x2).to_i
                if x > $max then
                    $max = x
                    md = d
                    check = x2 - d * y * y
                    puts "#{d} #{x} (#{x*x} #{x2}) #{y} => #{check} "
                end
                break
            end
        end
    end
    puts "MAX #{max} #{md}"
    max
end

ts = []
(1..10).each do |j|
    ts << Thread.new { problem66((j-1)*100, j * 100) }
end

ts.each do |t| 
    t.join
end

