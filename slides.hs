-- laziness-based caching

fibs :: [Integer]
fibs = 1:1:zipWith (+) fibs (tail fibs)

fib :: Int -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)


--  +--+    +--+    +--+    +--+    +--+    +--+    +--+    
--  | 1| -> | 1| -> | 2| -> | 3| -> | 5| -> |..| -> |..| -> ...
--  +--+    +--+    +--+    +--+    +--+    +--+    +--+    





























































































