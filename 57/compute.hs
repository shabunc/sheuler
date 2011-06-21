import Data.List

reduce (a, b) = (a `div` (gcd a b), b `div` (gcd a b))
step  1 = (1, 1)
step  n = let pr = step (n - 1); a = fst pr; b = snd pr in reduce(a + 2*b, a + b)

good_one (a,b) = length(show a) > length(show b)

main :: IO()
main = do
    print $ length $ filter (good_one) $ map (step) [1..1001]

