import Data.List
import Data.Char

digsum n = sum $ map (digitToInt) $ show n

good_one n = (digsum n == digsum (137 * n))

brute :: Int -> [Int]
brute n = filter (good_one) [1..n]

main :: IO()
main = do
    print $ length $ brute (10^8)  
