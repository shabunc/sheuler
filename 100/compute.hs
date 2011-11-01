import Data.List
import Control.Monad


main :: IO()
main = do
    print $  take 3 $ map (round.root) $ filter (isin) disks
            where disks = map (\a -> a * (a - 1)) [10 ** 5..]
                  root a = sqrt(a + 0.25) + 0.5
                  isin a =  b == fromInteger (round b) where b = root(a * 2)
