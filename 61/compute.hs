import Data.List
import Data.Char


figures :: Int -> [Int]
figures n = scanl1 (+) [1, (n-1) ..]

fromto :: Int -> Int -> [Int] -> [Int]
fromto from to ls = dropWhile (< from) $ takeWhile (< to) $ ls 

figs n = fromto 1000 10000 $ figures n

are_siblings :: [Int] -> [Int] -> Bool
are_siblings a b
    | a!!2 == b!!0 && a!!3 == b!!1 = True
    | otherwise = False

digs n = map (digitToInt) $ show n

main :: IO()
main = do
    --print $ [[a,b,c] | a <- figs 3, b <- figs 4, c <- figs 5, are_siblings (digs a) (digs b), are_siblings (digs b) (digs c), are_siblings (digs c) (digs a)]
    print $  2882 `elemIndex` figures 5

