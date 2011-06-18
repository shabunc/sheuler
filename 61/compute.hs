import Data.List
import Data.Char


figures :: Int -> [Int]
figures n = scanl1 (+) [1, (n-1) ..]

fromto :: Int -> Int -> [Int] -> [Int]
fromto from to ls = dropWhile (< from) $ takeWhile (< to) $ ls 

figs n = fromto 1000 10000 $ figures n

are_siblings a b = (drop 2 a) == (take 2 b)

is_pretty_match l = all (\a -> are_siblings (fst a) (snd a)) $ zip l (tail $ cycle l)

problem61 xs ys = filter (is_pretty_match) [[show a, show b] | a <- xs, b <- ys]

main :: IO()
main = do
    print $  map (\a -> map (figs) a) $ permutations [3,4,5]
    print $  filter (is_pretty_match) [[show a, show b, show c] | a <- (figs 3), b <- (figs 4), c <- (figs 5)]
    print $  filter (is_pretty_match) [[show a, show b, show c] | a <- (figs 3), b <- (figs 5), c <- (figs 4)]
    -- print $ is_pretty_match ["8128", "2882", "8281"]

