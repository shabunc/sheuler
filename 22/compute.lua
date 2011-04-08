#!/usr/bin/env lua

dofile("names.txt")
table.sort(NAMES)

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

function word2sum(word)
    local sum = 0
    for l in string.gmatch(word, ".") do
        sum = sum + LETTERS[l]
    end
    return sum
end

function problem(names)
    local total = 0
    for i, name in pairs(names) do
        total = total + word2sum(name) * i
    end
    return total
end

total = problem(NAMES)
print(total)
