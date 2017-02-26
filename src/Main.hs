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

--data Kleisli m a b = Kleisli { runKleisli :: a -> m b }
main :: IO ()
main = do
    ((),()) <- runKleisli (rowsFirst (go 1) (go 2) (go 3) (go 4)) ((),())
    putStrLn "---"
    ((),()) <- runKleisli (colsFirst (go 1) (go 2) (go 3) (go 4)) ((),())
    return ()
  where
    go :: Int -> Kleisli IO () ()
    go x = Kleisli $ \() -> print x
