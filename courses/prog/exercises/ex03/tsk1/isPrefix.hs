{-| Schreiben Sie eine Funktion isPrefix, so dass isPrefix a b angbit, ob die
    Zeichenkette b mit der Zeichenkette a beginnt. -}

isPrefix :: String -> String -> Bool
isPrefix [] _ = True
isPrefix _ [] = False
isPrefix (x:xs) (y:ys)
  | x == y    = isPrefix xs ys
  | otherwise = False
