data Tree a = Node a [Tree a]
  deriving Show

{-| Schreiben Sie den Baum

        a
       /|\
      / | \
     /  |  \
    b   e   g
   / \  |
  c   d f

    als Haskell-Ausdruch des Typs Tree Char-}
mytree :: Tree Char
mytree = Node 'a' [(Node 'b' [(Node 'c' []), (Node 'd' [])]), (Node 'e' [(Node 'f' [])]), (Node 'g' [])]

{-| Schreiben Sie eine Funktion oddTree, die für einen Baum ermittelt, ob jeder
    innere Knoten eine ungerade Anzahl an Kindknoten hat -}
oddTree :: Tree a -> Bool
oddTree (Node a []) = True
oddTree (Node a (x:xs)) = ((length (x:xs)) `mod` 2 == 1) && all oddTree (x:xs)


{-| Schreiben Sie eine Funktion, welche einen Baum im Pre-Order-Durchlauf
    abläuft und die Beschriftung der Elemente ausgibt -}
preOrder :: Tree a -> [a]
preOrder (Node a []) = [a]
preOrder (Node a (x:xs)) = a:(concatMap preOrder (x:xs))
