import Data.List
import Data.Char

fib n = snd (pow n) where
            pow 0 = (0, 1)
            pow n | even n = let (a, b) = pow (quot n 2) in (2 * a * b - a ^ 2, a ^ 2 + b ^ 2)
                  | otherwise  = let(a, b) = pow(n - 1) in (b, a + b) 

digits n = map (digitToInt) $ show n
pref_pandigital n = (sort $ take 9 $ digs) == [1 .. 9] where digs = digits n
post_pandigital n = (sort $ drop ((length digs) - 9) $ digs) == [1 .. 9] where digs = digits n
good_one n = (pref_pandigital n) && (post_pandigital n)

main :: IO()
main = do
    print $ (dropWhile (\a -> not $  good_one (snd a)) $ map ( \n -> (n, fib n)) [2..]) !! 0

