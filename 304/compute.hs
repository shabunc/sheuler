import Data.List

is_prime :: Int -> Bool
is_prime n = all ((/=0).(mod n)) [2 .. floor(fromIntegral(n) ** 0.5)]

next_prime n =  (dropWhile ((==False).is_prime) [(n + 1) .. ]) !! 0
primes from count = tail $ take (count + 1) $ iterate (next_prime) from

fibs = 0 : (scanl (+) 1 fibs)
fib n = fibs !! n

problem304 n = sum $ map (fib) $ primes (10^14) (10^5)

main::IO()
main = do
    print $  primes (10^14) 10 
