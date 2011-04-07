#!/usr/bin/env lua

function square_sums(n) 
    res = n * (n + 1) * 0.5
    res = res * res
    return res
end

function sum_squares(n)
    res = n * (n + 1) * (n +1) * 0.5
    for j= 1, n do
        res = res - (n + 1 - j) * j
    end
    return res
end

function brute_force(n) 
    return square_sums(n) - sum_squares(n)
end

