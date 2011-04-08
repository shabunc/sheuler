#!/usr/bin/env lua

LETTERS = {
    A = 1,
    B = 2,
    C = 3,
    D = 4,
    E = 5,
    F = 6,
    G = 7,
    H = 8,
    I = 9,
    J = 10,
    K = 11,
    L = 12,
    M = 13,
    N = 14,
    O = 15,
    P = 16,
    Q = 17,
    R = 18,
    S = 19,
    T = 20,
    U = 21,
    V = 22,
    W = 23,
    X = 24,
    Y = 25,
    Z = 26
}

dofile("words.txt")

function triangle_numbers(max) 
    local res = {}
    local num = 0
    local n = 0
    while num < max do
        n = n + 1
        num = n * (n + 1) * 0.5
        res[num] = 1
    end
    return res
end

function find_triangle_words(words) 
    local trn = triangle_numbers(1300)
    local total = 0
    for k,word in pairs(words) do
        local sum = 0
        for l in string.gmatch(word, ".") do
            sum = sum + LETTERS[l]
        end
        if trn[sum] then
            total = total + 1
        end
    end
    return total
end

found = find_triangle_words(WORDS)
print(found)
