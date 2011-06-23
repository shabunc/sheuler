import Data.List

reduce (a, b) = (a `div` (gcd a b), b `div` (gcd a b))

invert (a, b) = (b, a)
add (a, b) (c, d) = reduce (a * d + c * b, b * d)

step (c, d) (a, b) = add (1, 1) $ invert $ add (c, d) (a, b) 

sq (a, b) = step (1, 1) (a, b)

main :: IO()
main = do
    --print $ take 5 $ map (fst) $ iterate (sq) ((1, 1), 1)
    --print $ take 5 $ map (fst) $ iterate (rexp) ((2, 1), 1)
    print $ take 5 $ iterate (sq) (1, 1)
