import Data.List

movedown = map (+2)
moveleft = map (+1)

data Trino = G | Gm | L | Lm | I | Ir
                deriving (Show, Eq)

load G = [0, 1, 2]
load Gm = [0, 1, 3]
load L = [0, 2, 3]
load Lm = [1, 2, 3]
load I = [0, 2, 4]


main :: IO()
main = do
    print $ iterate movedown $ load L
