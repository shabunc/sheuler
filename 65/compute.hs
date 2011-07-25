import Data.List

reduce (a, b) = (a `div` (gcd a b), b `div` (gcd a b))

fexp n
    | (n - 1) `mod` 3 == 0 = (0, 1)
    | (n - 1) `mod` 3 == 1 = (2 * ((n - 2) `div` 3 + 1) - 1, 1)
    | otherwise = (0, 1)

h -2 a = (0, 1)
h -1 a = (1, 0)

main :: IO()
main = do
    --print $ take 5 $ map (fst) $ iterate (sq) ((1, 1), 1)
    --print $ take 5 $ map (fst) $ iterate (rexp) ((2, 1), 1)
    print $ rexp ((1,1), 1)

