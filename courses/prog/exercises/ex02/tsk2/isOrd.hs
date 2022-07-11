{-| Implementieren Sie eine Funktion isOrd, die für eine gegebene Liste prüft ob
    diese aufsteigend sortiert ist. -}

isOrd :: [Int] -> Bool
isOrd [] = True
isOrd [x] = True
isOrd (x:y:xs)
  | x > y     = False
  | otherwise = isOrd (y:xs)
