--import Control.Monad
import Data.List

divisors :: Integer -> [Integer] -> Integer -> [Integer]
divisors n divs from  
        | n == from  = nub $ insert from divs
        | n `mod` from == 0 = divisors (n `div` from) (nub $ insert from divs) from
        | otherwise = divisors n divs (if from == 2 then 3 else from + 2)

totient :: Integer -> Integer
totient 1 = 1
totient n = foldl (\res p -> res `div` p * (p - 1)) n (divisors n [] 2)

totient2 :: Integer -> Integer
totient2 n = n * totient n

is_cube :: Integer -> Bool
--is_cube n = (dropWhile (\a -> a^3 < n) [1..] !! 0) ^ 3 == n
is_cube n = (round (fromIntegral n ** (1/3))) ^ 3 == n 

main :: IO()
main = do
    print $ sum $ filter (\n -> is_cube $ totient2 n) [1..10^10]
