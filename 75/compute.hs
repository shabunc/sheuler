--import Control.Monad
import Data.List

triangles :: Integer -> [(Integer, Integer, Integer)]
triangles p = [(a, b, c) | a <- [1 .. p - 2], b <- [1 .. p - 2], c <- [1 .. p - 2], a < b, b < c, a + b > c, a^2 + b^2 == c^2, a + b + c == p] 

problem75 n = filter (\a -> length(triangles a) == 1) [3 .. n]

main :: IO()
main = do
    print $ length $ problem75 150
    --print $ problem342(10^5)
    -- print $ sum $ filter (\n -> is_cube $ totient2 n) [1..10^10]
