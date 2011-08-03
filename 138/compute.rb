#!/usr/bin/env ruby

def stackstep(maxp)
    stack = [[3, 4, 5]]
    while !stack.empty? do
        a, b, c = stack.delete_at(0)
        #if a > 0 and b > 0 and c > 0 and (a + b + c) < maxp then
        if a > 0 and b > 0 and c > 0 and [a, b, c].max < maxp
            yield a, b, c
            [-a, a].each do |la|
                [-b, b].each do |lb|
                    na = la + 2 * lb + 2 * c
                    nb = 2 * la + lb + 2 * c
                    nc = 2 * la + 2 * lb + 3 * c
                    stack << [na, nb, nc]
                end
            end
        end
    end
end

def genall(maxp)
    total = 0
    sum = 0
    stackstep(maxp) do |na, nb, nc|
        a, b, c = [na, nb, nc].sort
        diff = (b - 2 * a).abs
        if 2 * a == (b + 1) or 2*a == (b - 1) then
            total = total + 1
            sum = sum + c
            puts "#{a} #{b} #{c}  #{sum} [#{total}] #{(b - 2 *a).to_i}"
        end
    end
    puts "TOTAL #{total}"
    puts "SUM #{sum}"
end

genall(10 ** 11)
