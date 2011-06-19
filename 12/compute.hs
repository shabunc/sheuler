import Control.Monad
import Data.List

divisors :: Integer -> [Integer] -> Integer -> [Integer]
divisors n divs from  
        | n == from  = nub $ insert from divs
        | n `mod` from == 0 = divisors (n `div` from) (nub $ insert from divs) from
        | otherwise = divisors n divs (if from == 2 then 3 else from + 2)

proper_divisors :: Int -> [Int]
proper_divisors n = [x | x <- [1..(n `div` 2)], n `mod` x == 0] ++ [n]

divz n = filter (==0) $ map (mod n) [1..n]

count :: Int -> [Int] -> Int 
count n [] = 0 
count x (y:ys)
    | x == y = 1 + (count x ys) 
    | otherwise = count x ys


problem12 :: Int -> [Int]
problem12 n =  takeWhile ((<=n).length.divz) (scanl1 (+) [1, 2..]) 

main :: IO()
main = do
     mapM_ print $ problem12 500 
    --print $ problem342(10^5)
    -- print $ sum $ filter (\n -> is_cube $ totient2 n) [1..10^10]
