module Main where
import Test.DocTest

import Control.Monad.IO.Class
import Control.Monad.State
import Control.Monad.Writer


withFile :: FilePath -> IO a -> IO a
withFile filePath body = do
  putStrLn ("opening " ++ filePath)
  x <- body
  putStrLn ("closing " ++ filePath)
  pure x

-- |
-- >>> execWriterT $ liftedWithFile "myfile" $ tell ["abc"]
-- opening myfile
-- closing myfile
-- ["abc"]
-- >>> flip execStateT "foo" $ liftedWithFile "myfile" $ modify (++ "!")
-- opening myfile
-- closing myfile
-- "foo!"
liftedWithFile :: MonadIO m => FilePath -> m a -> m a
liftedWithFile filePath body = do
  liftIO $ putStrLn ("opening " ++ filePath)
  x <- body
  liftIO $ putStrLn ("closing " ++ filePath)
  pure x


main :: IO ()
main = doctest ["src/Main.hs"]
