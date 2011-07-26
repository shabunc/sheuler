#!/usr/bin/env ruby

def is_square(n)
    sq = Math.sqrt(n).floor
    sq * sq == n
end

$max = 1766319049 

def problem66(from, to)
    md = -1
    (from..to).each do |d|
        puts d
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
                    STDOUT.flush
                end
                break
            end
        end
    end
    puts "MAX #{$max} #{md}"
    STDOUT.flush
end

problem66(600, 700)

=begin
ts = []
(1..20).each do |j|
    scale = 50
    Thread.new { problem66((j-1) * scale, j * scale) }
end

ts.each do |t| 
    t.join
end

=end
