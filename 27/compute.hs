--import Control.Monad
import Data.List
import Data.Function


divisors :: Integer -> [Integer] -> Integer -> [Integer]
divisors 0 _ _  = []
divisors 1 _ _  = []
divisors n divs from  
        | n == from  = nub $ insert from divs
        | n `mod` from == 0 = divisors (n `div` from) (nub $ insert from divs) from
        | otherwise = divisors n divs (if from == 2 then 3 else from + 2)

divs :: Integer -> [Integer]
divs n = divisors n [] 2

is_prime :: Integer -> Bool
is_prime n = let divs = divisors n [] 2 in length(divs) == 1 && (divs!!0 == n)

poly :: [Integer] -> Integer -> Integer
poly ks n = sum $ map (\a -> fst a * snd a) (zip ks (iterate (\a -> n * a) 1))

chain :: [Integer] -> [Integer]
chain ks = takeWhile (\p -> is_prime(abs(p)))[ poly ks n | n <- [0 .. ]]


problem27 n = sort [(length $ chain [a,b,1], a, b) | a <- [-n .. n], b <- [-n .. n]]

main :: IO()
main = do
    --print $ length $ filter is_prime [1 .. 1000]
    print $ problem27 1000
