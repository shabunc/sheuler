function dec(n, k) {
    if (n == 1) {
        return k + 1
    }
    return dec(n - 1, k) + dec(n, k - 1)
}
