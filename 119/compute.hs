import Data.List
import Data.Char

ispowerof n 1 = False
ispowerof n d = (last $ takeWhile (<= n) $ iterate (*d) d) == n

digsum n = sum $ map digitToInt $ show n

isgood n = ispowerof n (digsum n)

main :: IO()
main = do
    print $ take 15 $ filter (isgood) [10..]
