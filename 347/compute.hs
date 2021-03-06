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
    | otherwise = last $ takeWhile (<= n) $ hamming p q

is_prime :: Integer -> Bool
is_prime n = null (filter ((==0). mod n) [2..floor(fromIntegral n ** 0.5)]) 

combs 0 _ = [[]]
combs k [] = []
combs k (x:xs) = map (x:) (combs (k - 1) xs) ++ combs k xs

prime n = sieve xs []  
            where
                xs = [2..n]
                sieve [] primes = primes
                sieve xs@(p:xs') primes 
                    | p * p > n = primes ++ xs
                    | otherwise = sieve filtered (primes ++ [p]) where filtered = filter ((/=0). flip mod p) xs'


main :: IO()
main = do
    print $ sum $ map (\a -> m (a!!0) (a!!1) n) $ combs 2 prim
                where 
                    n = 106
                    prim = prime n

