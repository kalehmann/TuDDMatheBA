{-| Schreiben Sie eine Funktion rev, welche eine gegebene Liste umkehrt. -}

rev :: [Int] -> [Int]
rev [] = []
rev (x:xs) = (rev xs) ++ [x]
