import Data.List
import Control.Monad

figures :: Int -> [Int]
figures n  = take 10^4 scanl1 (+) [1, (n - 1) .. ]

monofind :: [Int] -> Int -> Bool
monofind ls n = n `elemIndex` (dropWhile (<n) ls) == Just 0

f6 = figures 6
f5 = filter (monofind (figures 5)) f6

main :: IO()
main = do
    print $ f5!!1
