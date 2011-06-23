import Data.List

reduce (a, b) = (a `div` (gcd a b), b `div` (gcd a b))

step (a, b) n g  = reduce $ (a + ((g n) + 1) * b, a + (g n) *b)

sq ((a, b), n) = (step (a, b) n (\a -> 1), n + 1)

main :: IO()
main = do
    print $ take 5 $ iterate (sq) ((1, 1), 1)
