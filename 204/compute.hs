import Data.List

merge [] ys = ys
merge xs [] = xs
merge xs@(x : xs') ys@(y : ys') 
    | x == y = x : merge xs' ys'
    | x < y  = x : merge xs' ys 
    | otherwise = y : merge xs ys'


main :: IO()
main = do
    print $ length $ takeWhile (< 1000000000) $ foldl1 (merge) [
                                      (map (2 *) [1..]), 
                                      (map (3 *) [1..]),
                                      (map (5 *) [1..]),
                                      (map (7 *) [1..]),
                                      (map (11 *) [1..]),
                                      (map (13 *) [1..]),
                                      (map (17 *) [1..]),
                                      (map (19 *) [1..]),
                                      (map (23 *) [1..]),
                                      (map (29 *) [1..]),
                                      (map (31 *) [1..]),
                                      (map (37 *) [1..]),
                                      (map (41 *) [1..]),
                                      (map (43 *) [1..]),
                                      (map (53 *) [1..]),
                                      (map (59 *) [1..]),
                                      (map (61 *) [1..]),
                                      (map (67 *) [1..]),
                                      (map (71 *) [1..]),
                                      (map (73 *) [1..]),
                                      (map (79 *) [1..]),
                                      (map (83 *) [1..]),
                                      (map (89 *) [1..]),
                                      (map (97 *) [1..])
                                    ]



