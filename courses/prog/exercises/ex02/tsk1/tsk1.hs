{-| Geben Sie eine Haskell-Funktion bincoeff an, die für zwei Zahlen n und k
    den Binominalkoeffizienten n über k berechnet -}

bincoeff :: Int -> Int -> Int
bincoeff n k = (fac n) `div` (fac (n - k) * fac k)
  where
    fac :: Int -> Int
    fac 0 = 1
    fac n = n * fac (n - 1)
