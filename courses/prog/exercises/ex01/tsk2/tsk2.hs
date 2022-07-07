{-| Schreiben Sie eine Funktion fac, sodass für n >= 0 die Fakultät von n
    berechnet wird.
    Für n < 0 soll die Funktion nicht definiert sein. -}

fac :: Int -> Int
fac 0 = 1
fac n | n > 0= n * fac (n - 1)

{-| Schreiben Sie nun eine Funktion sumFacs, so dass sumFacs n m die Summe
    der Fakultäten von i = n bis m berechnet -}

sumFacs :: Int -> Int -> Int
sumFacs n m
  | n == m = 0
  | n < m = sumFacs n (m - 1) + fac m
