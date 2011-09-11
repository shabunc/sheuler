import Data.List
import Control.Monad

merge [] ys = ys
merge xs [] = xs
merge xs@(x:xs') ys@(y:ys') 
        | x < y = x : merge xs' ys
        | x == y = x : merge xs' ys'
        | otherwise = y : merge xs ys'

hamming :: Integer -> Integer -> [Integer]
hamming p q = p*q : merge (map (p *) ham) (map (q *) ham) 
                where ham = hamming p q

m p q n 
    | p >= q = 0
    | (p * q) > n = 0
    | otherwise = last $ takeWhile (< n) $ hamming p q

is_prime :: Integer -> Bool
is_prime n = null (filter ((==0). mod n) [2..floor(fromIntegral n ** 0.5)]) 

combs 0 _ = [[]]
combs k [] = []
combs k (x:xs) = map (x:) (combs (k - 1) xs) ++ combs k xs

primes n = filter is_prime [2 .. n]

main :: IO()
main = do
    print $ sum $ map (\a -> m (a!!0) (a!!1) 100) $ combs 2 prim
                where prim = primes 100

