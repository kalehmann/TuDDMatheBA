{-| Implementieren Sie eine Funktion, die für die Eingabe einer Zahl i das i-te
    Glied der Fibonacci-Folge errechnet -}

fib :: Int -> Int
fib 1 = 1
fib 2 = 1
fib n | n > 0 = fib (n - 2) + fib (n - 1)
