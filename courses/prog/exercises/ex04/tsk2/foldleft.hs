{-| Implementieren Sie eine Funktion foldleft -}

foldleft :: (a -> b -> a) -> a -> [b] -> a
foldleft _ a [] = a
foldleft f a (x:xs) = f (foldleft f a xs) x
