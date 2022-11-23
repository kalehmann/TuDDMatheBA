{-| Implementieren Sie eine Funktion f, die mit Hilfe von map, filter und
    foldr das Produkt der Quadrate der geraden Zahlen in der Eingabeliste
    berechnet. -}
f :: [Int] -> Int
f x = foldr (+) 0 (map square (filter isEven x))
  where
    square :: Int -> Int
    square x = x * x
    isEven :: Int -> Bool
    isEven x = x `mod` 2 == 0
