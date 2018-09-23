module Main where  {- slide 4 of 7 -}


finally :: IO a -> IO b -> IO a

class Hard m where
  liftAnything :: (IO a -> IO b -> IO a)
               -> (m  a -> m  b -> m  a)

class Easy m where
  liftedFinally :: m a -> m b -> m a










































finally = undefined


main :: IO ()
main = putStrLn "typechecks."
