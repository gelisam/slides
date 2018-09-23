module Main where  {- slide 7 of 7 -}


finally :: IO (a, StateM) -> IO (b, StateM) -> IO (a, StateM)

class Hard m where
  liftAnything :: (IO a -> IO b -> IO a)
               -> (m  a -> m  b -> m  a)

class Easy m where
  liftedFinally :: m a -> m b -> m a


finally' :: IO (a, StateM)
         -> (Maybe (a, StateM) -> IO (b, StateM))
         -> IO (b, StateM)

class Easier m where
  liftedFinally' :: m a
                 -> (Maybe a -> m b)
                 -> m b






































data StateM

finally = undefined
finally' = undefined


main :: IO ()
main = putStrLn "typechecks."
