import Data.List

reduce (a, b) = (a `div` (gcd a b), b `div` (gcd a b))

step (a, b) n g  = reduce $ (a + ((g n) + 1) * b, a + (g n) *b)

sq ((a, b), n) = (step (a, b) n (\a -> 1), n + 1)

exp_f n  
    | (n - 1) `mod` 3 == 0 = 0
    | (n - 1) `mod` 3 == 1 = 2 * ((n-2) `div` 3 + 1) - 1
    | otherwise = 0

rexp ((a, b), n) = (step (a, b) n (exp_f), n + 1)

main :: IO()
main = do
    --print $ take 5 $ map (fst) $ iterate (sq) ((1, 1), 1)
    print $ take 5 $ map (fst) $ iterate (rexp) ((2, 1), 1)
