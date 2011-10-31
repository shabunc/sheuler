import Data.List

lilxs = [[7,  53, 183, 439, 863], [497, 383, 563,  79, 973], [287,  63, 343, 169, 583], [627, 343, 773, 959, 943], [767, 473, 103, 699, 303]]

remrow j xs = (take j xs) ++ (drop (j + 1) xs)
remcol j xs = map (remrow j) xs
remove i j = (remrow i) . (remcol j)

ranks xs = [(remove i j xs, xs !! i !! j) | i <- [0 .. n], j <- [0 .. n]] where n = (length xs - 1)


main :: IO()
main = do
    print $ ranks lilxs
