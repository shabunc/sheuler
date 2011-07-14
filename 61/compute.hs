import Data.List
import Data.Char


figures :: Int -> [Int]
figures n = scanl1 (+) [1, (n-1) ..]

fromto :: Int -> Int -> [Int] -> [Int]
fromto from to ls = dropWhile (< from) $ takeWhile (< to) $ ls 

figs n = fromto 1000 10000 $ figures n

are_siblings a b = (drop 2 a) == (take 2 b)

all_pretty_match l = all (\a -> are_siblings (fst a) (snd a)) $ zip l (tail $ cycle l)
any_pretty_match l = any (all_pretty_match) $ permutations l

can_be_pretty xs =  (length $ nub $ concat $ map (\a -> [drop 2 a, take 2 a]) xs) == length xs

combs n ls = filter ((n==).length) (subsequences ls)


main :: IO()
main = do
    print $  filter (any_pretty_match) $ filter (can_be_pretty) [[show a, show b, show c, show d, show e, show f] | a <- (figs 3), b <- (figs 4), c <- (figs 5), d <- (figs 6), e <- (figs 7), f <- (figs 8)]
    {-
    print $  filter (any_pretty_match) $ filter (can_be_pretty) [[show a, show b, show c] | a <- (figs 3), b <- (figs 5), c <- (figs 4)]
    print $  filter (can_be_pretty) [[show a, show b, show c] | a <- (figs 3), b <- (figs 5), c <- (figs 4)]
    print $  filter (any_pretty_match) [[show a, show b, show c, show d, show e, show f] | a <- (figs 3), b <- (figs 4), c <- (figs 5), d <- (figs 6), e <- (figs 7), f <- (figs 8)]
    print $  map (\a -> map (figs) a) $ permutations [3,4,5]
    -}
    -- print $ is_pretty_match ["8128", "2882", "8281"]

