--import Control.Monad
import Data.List

triangles :: Integer -> [(Integer, Integer, Integer)]
triangles p = [(a, b, c) | a <- [1 .. p - 2], b <- [a .. p - 2 - a], c <- [p - a - b], b < c, a + b > c, a^2 + b^2 == c^2] 

problem75 n = filter (\a -> length(triangles a) == 1) [3 .. n]

main :: IO()
main = do
    print $ problem75 1500
    --print $ problem342(10^5)
    -- print $ sum $ filter (\n -> is_cube $ totient2 n) [1..10^10]
