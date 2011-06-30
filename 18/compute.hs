data Tree = Tip | Node a (Tree a) (Tree a)
leaf x = Node x Tip Tip

main :: IO()
main = do
    print $ sha lala

