douce as bs = [(a,b) | a <- as, b <- bs]
points n = tail $ douce [0..n] [0..n]

problem91 n = filter (\xy -> fst(xy) /= snd(xy)) $ douce (points n) (points n)

main :: IO()
main = do
    print $ problem91 2
