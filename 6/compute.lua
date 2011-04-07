#!/usr/bin/env lua

function square_sums(n) 
    res = n * (n + 1) * 0.5
    res = res * res
    return res
end

function sum_squares(n)
    res = n * (2*n + 1) * (n + 1) 
    res = res / 6
    return res
end

function diff(n) 
    return square_sums(n) - sum_squares(n)
end

