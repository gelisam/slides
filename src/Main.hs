module Main where
import Test.DocTest

import Control.Monad.IO.Class
import Control.Monad.Reader


withFile :: FilePath -> IO a -> IO a
withFile filePath body = do
  putStrLn ("opening " ++ filePath)
  x <- body
  putStrLn ("closing " ++ filePath)
  pure x

liftedWithFile :: FilePath -> ReaderT r IO a -> ReaderT r IO a
liftedWithFile filePath body = ReaderT $ \r -> do
  liftIO $ withFile filePath (runReaderT body r)


main :: IO ()
main = doctest ["src/Main.hs"]
