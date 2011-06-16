import Data.List
import Data.Char

is_diadic :: Int -> Bool
is_diadic n = any (\d -> d > 2) (map digitToInt $ show n)

f :: Int -> Int
f n = (dropWhile (is_diadic) $ zipWith (*) (repeat n) [1 ..]) !! 0

main :: IO()
main = do
    print $  f 999
