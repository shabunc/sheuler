import Data.List

figures :: Int -> [Int]
figures n = scanl1 (+) [1, (n-1) ..]

fromto :: Int -> Int -> [Int] -> [Int]
fromto from to ls = dropWhile (< from) $ takeWhile (< to) $ ls 

are_siblings :: [Int] -> [Int] -> Bool
are_siblings a b
    | a!!2 == b!!0 && a!!3 == b!!1 = True
    | otherwise = False

main :: IO()
main = do
    print $ are_siblings [8,1,2,8] [2,8,8,2]
