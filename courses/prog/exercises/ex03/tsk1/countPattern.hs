{-| Schreiben Sie eine Funktion countPattern welche zwei Zeichenketten entgegen
    nimmt und dabei prüft wie oft die eirste Zeichenkette in der zweiten
    Zeichenkette enthalten ist. -}

countPattern :: String -> String -> Int
countPattern [] [] = 1
countPattern [] (x:xs) = 1 + countPattern [] xs
countPattern _ [] = 0
countPattern x (y:ys)
  | isPrefix x (y:ys) = 1 + countPattern x ys
  | otherwise         = countPattern x ys
  where
    isPrefix :: String -> String -> Bool
    isPrefix [] _ = True
    isPrefix _ [] = False
    isPrefix (x:xs) (y:ys)
      | x == y    = isPrefix xs ys
      | otherwise = False
