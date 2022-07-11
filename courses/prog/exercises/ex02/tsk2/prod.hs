{-| Schreiben Sie eine Funktion prod, die Zahlen in einer gegebenen Liste
    aufmultipliziert. -}

prod :: [Int] -> Int
prod [] = 1
prod (x:xs) = x * prod xs
