import Data.List

reduce (a, b) = (a `div` (gcd a b), b `div` (gcd a b))

step (a, b) = reduce $ (a + 2 * b, a + b)

main :: IO()
main = do
    print $ take 100 $  iterate (step) (1,1)
