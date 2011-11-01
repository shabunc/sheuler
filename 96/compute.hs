su1 = [[0, 0, 3, 0, 2, 0, 6, 0, 0], [9, 0, 0, 3, 0, 5, 0, 0, 1], [0, 0, 1, 8, 0, 6, 4, 0, 0], [0, 0, 8]

cols :: [[a]] -> [[a]]
cols [xs] = [[x] | x <- xs]
cols (xs : xss) = zipWith (:) xs (cols xss)

group :: [a] -> [[a]]
group [] = []
group xs = take 3 xs : group (drop 3 xs)


main :: IO()
main = 
    print $ group su1
