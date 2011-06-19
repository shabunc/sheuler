import Data.List

douce as bs = [[a,b] | a <- as, b <- bs]
points n = tail $ douce [0..n] [0..n]

combinations :: Int -> [a] -> [[a]]
combinations 0 _  = [[]]
combinations n xs = [ y:ys | y:xs' <- tails xs, ys <- combinations (n-1) xs']

pythas :: (Int,Int) -> (Int, Int) -> (Int, Int) -> Bool
pythas _ _ _ = True

are_orthos :: [Int] -> [Int] -> Bool
are_orthos xs ys = all (==0) $ zipWith (*) xs ys 

are_pyhtas xs ys = any (\a -> are_orthos (a!!0) (a!!1)) $ combinations 2 $ [(zipWith (-) xs ys)] ++ [xs] ++ [ys]

problem91 n = nub $ filter (\a -> are_pyhtas (a!!0) (a!!1)) $ combinations 2 $ points n

main :: IO()
main = do
    print $ problem91 3
local

