{-| Implementieren Sie eine Funktion merge, die zwei aufsteigend sortierte
    Listen zu einer aufsteigend sortierten Liste vereinigt. -}

merge :: [Int] -> [Int] -> [Int]
merge x [] = x
merge [] x = x
merge (x:xs) (y:ys)
  | x < y     = x:(merge xs (y:ys))
  | otherwise = y:(merge (x:xs) ys)
