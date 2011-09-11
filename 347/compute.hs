import Data.List

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
    | (p * q) > n = 0
    | otherwise = last $ takeWhile (< n) $ hamming p q

main :: IO()
main = do
    print $ m 3 55 100
