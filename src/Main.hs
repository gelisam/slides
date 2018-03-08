module Main where
import Test.DocTest

import Control.Monad.IO.Class
import Control.Monad.State
import Control.Monad.Writer

-- |
-- >>> withFile "myfile" $ putStrLn "doing stuff with myfile"
-- opening myfile
-- doing stuff with myfile
-- closing myfile
withFile :: FilePath -> IO a -> IO a
withFile filePath body = do
  putStrLn ("opening " ++ filePath)
  x <- body
  putStrLn ("closing " ++ filePath)
  pure x

-- |
-- >>> execWriterT $ liftedWithFile "myfile" $ tell ["abc"]
-- ...
-- ...undefined
-- ...
-- >>> flip execStateT "foo" $ liftedWithFile "myfile" $ modify (++ "!")
-- ...
-- ...undefined
-- ...
liftedWithFile :: MonadIO m => FilePath -> m a -> m a
liftedWithFile filePath = liftIO             -- IO a -> m a
                        . withFile filePath  -- IO a -> IO a
                        . undefined          -- m a  -> IO a


main :: IO ()
main = doctest ["src/Main.hs"]
