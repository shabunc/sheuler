import Data.List

fact n = product [1..n]
c k n = (fact n) `div` ((fact k) * (fact $ n - k))

bad_one min (_, _, rem) = rem <= min

main :: IO()
main = do
    print $  take 1 $ dropWhile (bad_one (10^9)) $ [(n, a, 2 * n * a `mod` a^2)| n <- [7001, 7003..8000], a <- [1..50000]]
