{-# LANGUAGE RankNTypes #-}




type Fold s a = forall m. Monoid m => (a -> m) -> (s -> m)




















































data Const m a = Const m


main :: IO ()
main = putStrLn "done."
