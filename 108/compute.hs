import Data.List

compute n d 
    | n `mod` d /= 0 = 0 
    | n `div` d == d = 1
    | otherwise = 2

search n  =  sum $ map (compute n) [1 .. floor((fromIntegral n) ** 0.5)] 

problem108 n = head $ dropWhile (\a -> snd a <= n) $ zipWith (,) xs (map search xs) 
            where xs = [1..]

main :: IO()
main = do
    print $ problem108 1000
           
          
