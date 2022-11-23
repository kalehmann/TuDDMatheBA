data BinTree = Branch Int BinTree BinTree | Nil
  deriving Show

{-| Geben Sie einen Haskell-Ausdruck  myTree des Typs BinTree für den folgenden
    Baum an:
      0
       \
        3
       / \
      1   5    -}

mytree :: BinTree
mytree = Branch 0 Nil (Branch 3 (Branch 1 Nil Nil) (Branch 5 Nil Nil))

{-| Geben Sie eine Funktion inklusive Typdefinition an, welche testet ob zwei
    Binärbäume vom Typ BinTree identisch sind. -}
treeComp :: BinTree -> BinTree -> Bool
treeComp Nil Nil = True
treeComp _ Nil = False
treeComp Nil _ = False
treeComp (Branch x xl xr) (Branch y yl yr)
  | x == y    = treeComp xl yl && treeComp xr yr
  | otherwise = False

{-| Schreiben Sie eine Funktion insert, die alle Werte einer Liste von
    ganzen Zahlen in einen bestehenden Suchbaum einfügt, so dass die
    Suchbaumeigenschaft erhalten bleibt.
    Die Suchbaumeigenschaft besagt, dass für jeden Knoten die Beschriftung
    größer oder gleich der Beschriftung im linken Teilbaum und kleiner oder
    gleich der Beschriftung im rechten Teilbaum ist. -}
insert :: BinTree -> [Int] -> BinTree
insert x [] = x
insert tr (x:xs) = insert (insertSingle tr x) xs
  where
    insertSingle :: BinTree -> Int -> BinTree
    insertSingle Nil x = (Branch x Nil Nil)
    insertSingle (Branch y yl yr) x
      | x > y     = (Branch y yl (insertSingle yr x))
      | otherwise = (Branch y (insertSingle yl x) yr)

tree :: BinTree
tree = Branch 1 (Branch 2 (Branch 7 Nil Nil) (Branch 6 Nil Nil)) (Branch 3 (Branch 5 Nil Nil) (Branch 4 Nil Nil)) 
