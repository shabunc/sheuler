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

are_pyhtas :: [Int] -> [Int] -> [[Int]]
are_pyhtas xs ys = [(zipWith (-) xs ys)] ++ [xs] ++ [ys]

main :: IO()
main = do
    print $ are_pyhtas [1,0] [1,2]
