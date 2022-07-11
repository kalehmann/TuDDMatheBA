{-| Schreiben Sie einen Funktion excl, so dass excl x xs die Liste xs, ohne
    Vorkommen von x zurück gibt. -}

excl :: Int -> [Int] -> [Int]
excl _ [] = []
excl y (x:xs)
  | y == x    = excl y xs
  | otherwise = x:(excl y xs)
