{-| Implementieren Sie die unendliche Liste fibs der Fibonacci Zahlen -}

nats :: [Int]
nats = 0:(map (+1) nats)

fib :: Int -> Int
fib x
  | x == 0    = 1
  | x == 1    = 1
  | otherwise = fib (x - 1) + fib(x - 2)

fibs :: [Int]
fibs = map fib nats
