import Data.List
import Data.Char


figures :: Int -> [Int]
figures n = scanl1 (+) [1, (n-1) ..]

fromto :: Int -> Int -> [Int] -> [Int]
fromto from to ls = dropWhile (< from) $ takeWhile (< to) $ ls 

figs n = fromto 1000 10000 $ figures n

are_siblings a b
    | a!!2 == b!!0 && a!!3 == b!!1 = True
    | otherwise = False

is_pretty_match l = all (\a -> are_siblings (fst a) (snd a)) $ zip l (tail $ cycle l)

main :: IO()
main = do
    print $ [[a,b] | a <- figs 3, b <- figs 4, is_pretty_match [show a, show b]]
    -- print $ is_pretty_match ["8128", "2882", "8281"]

