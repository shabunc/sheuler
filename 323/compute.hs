import Data.List;

bits 0 = [[]]
bits n = [b:bs | b <- [0, 1], bs <- bits (n - 1)]

bitverse = permutations . bits

bitsor = zipWith (\a b -> a == 1 || b == 1)

xseq j n = head . bits
xseq j n = bitsor (xseq (n - 1)) 

main :: IO ()
main = 
    print $ xseq 0 3
