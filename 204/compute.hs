import Data.List

merge [] ys = ys
merge xs [] = xs
merge xs@(x : xs') ys@(y : ys') 
    | x == y = x : merge xs' ys'
    | x < y  = x : merge xs' ys 
    | otherwise = y : merge xs ys'

ham n = map (n *)

hamming :: [Integer]
hamming = 1 : foldl1 (merge) [
                    ham 2 hamming, 
                    ham 3 hamming,
                    ham 5 hamming,
                    ham 7 hamming,
                    ham 11 hamming,
                    ham 13 hamming,
                    ham 17 hamming,
                    ham 19 hamming,
                    ham 23 hamming,
                    ham 29 hamming,
                    ham 31 hamming,
                    ham 37 hamming,
                    ham 41 hamming,
                    ham 43 hamming,
                    ham 47 hamming,
                    ham 53 hamming,
                    ham 59 hamming,
                    ham 61 hamming,
                    ham 67 hamming,
                    ham 71 hamming,
                    ham 73 hamming,
                    ham 79 hamming,
                    ham 83 hamming,
                    ham 89 hamming,
                    ham 97 hamming
              ]


main :: IO()
main = do
    print $ length $ takeWhile (<= 1000000000) hamming




