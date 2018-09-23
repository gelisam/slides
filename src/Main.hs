module Main where  {- slide 5 of 7 -}


finally :: IO a -> IO b -> IO a

class Hard m where
  liftAnything :: (IO a -> IO b -> IO a)
               -> (m  a -> m  b -> m  a)

class Easy m where
  liftedFinally :: m a -> m b -> m a


finally' :: IO a
         -> (Maybe a -> IO b)
         -> IO b

class Easier m where
  liftedFinally' :: m a
                 -> (Maybe a -> m b)
                 -> m b








































finally = undefined
finally' = undefined


main :: IO ()
main = putStrLn "typechecks."
