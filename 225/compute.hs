import Data.List

tris = 1 : 1 : 1 : zipWith3 (\a b c -> a + b + c) tris (tail tris) (tail $ tail tris)

divs :: Integer -> [Integer]
divs n = sort $ concat $ map (\a -> [a, n `div` a]) $ filter ((==0).(mod n))  [1 .. floor((fromIntegral n) ** 0.5)] 

trdivs n = nub $ sort $ concat $ map (divs) $ take n tris

main :: IO()
main = do
    print $ divs 20153174455711123712868522236097194706311295377380511
