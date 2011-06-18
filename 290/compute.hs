import Data.List
import Data.Char

digsum n = sum $ map (digitToInt) $ show n

brute :: Int -> [Int]
brute n = [a | a <- [1 .. n], (digsum a) == (digsum $ 137*a)]

main :: IO()
main = do
    print $ length $ brute (10^7)
