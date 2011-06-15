--import Control.Monad
import Data.List

divisors :: Integer -> [Integer] -> Integer -> [Integer]
divisors n divs from  
        | n == from  = nub $ insert from divs
        | n `mod` from == 0 = divisors (n `div` from) (nub $ insert from divs) from
        | otherwise = divisors n divs (if from == 2 then 3 else from + 2)

proper_divisors :: Int -> [Int]
proper_divisors n = [x | x <- [1..n], n `mod` x == 0]

problem12 :: Int -> Int
problem12 n =  dropWhile (\a -> length(proper_divisors a) <= n ) [round (x * (x + 1) * 0.5) | x <- [1..]] !! 0

main :: IO()
main = do
    print $ problem12 500
    --print $ problem342(10^5)
    -- print $ sum $ filter (\n -> is_cube $ totient2 n) [1..10^10]
