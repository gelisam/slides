import Control.Arrow

--   +---+---+
--   | 1 | 2 |
--   +---+---+
--   | 3 | 4 |
--   +---+---+

rowsFirst, colsFirst :: Arrow k
                     => k a b -> k a' b'
                     -> k b c -> k b' c'
                     -> k (a,a') (c,c')
rowsFirst k1 k2 k3 k4 = (k1 *** k2) >>> (k3 *** k4)
colsFirst k1 k2 k3 k4 = (k1 >>> k3) *** (k2 >>> k4)


main :: IO ()
main = do
    print $ rowsFirst (++ "1") (++ "2") (++ "3") (++ "4") ("","")
    print $ colsFirst (++ "1") (++ "2") (++ "3") (++ "4") ("","")
