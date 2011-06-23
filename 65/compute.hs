import Data.List

reduce (a, b) = (a `div` (gcd a b), b `div` (gcd a b))

invert (a, b) = (b, a)
add (a, b) (c, d) = reduce (a * d + c * b, b * d)

step (c, d) (a, b) = add (2, 1) $ invert $ add (c, d) (a, b) 

sq ((a, b), n) = (step (1,1) (a, b), n + 1)

fexp n
    | (n - 1) `mod` 3 == 0 = (0, 1)
    | (n - 1) `mod` 3 == 1 = (2 * ((n - 2) `div` 3 + 1) - 1, 1)
    | otherwise = (0, 1)

rexp ((a, b), n) = (step (fexp n) (a, b), n + 1) 

main :: IO()
main = do
    --print $ take 5 $ map (fst) $ iterate (sq) ((1, 1), 1)
    --print $ take 5 $ map (fst) $ iterate (rexp) ((2, 1), 1)
    print $ rexp ((1,1), 1)

