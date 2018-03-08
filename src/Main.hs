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


class ToIO m where
  toIO :: m a -> IO a

liftedWithFile :: (MonadIO m, ToIO m) => FilePath -> m a -> m a
liftedWithFile filePath = liftIO . withFile filePath . toIO


-- |
-- >>> liftedWithFile "myfile" $ putStrLn "doing stuff with myfile"
-- opening myfile
-- doing stuff with myfile
-- closing myfile
instance ToIO IO where
  toIO = id

-- |
-- >>> execWriterT $ liftedWithFile "myfile" $ tell ["abc"]
-- opening myfile
-- closing myfile
-- []
instance ToIO m => ToIO (WriterT w m) where
  toIO (WriterT body) = do  -- body :: m (a, [w])
    (x, _) <- toIO body
    pure x

-- |
-- >>> flip execStateT "foo" $ liftedWithFile "myfile" $ modify (++ "!")
-- opening myfile
-- closing myfile
-- "foo"
instance ToIO m => ToIO (StateT s m) where
  toIO (StateT body) = do  -- body :: s -> m (a, s)
    (x, _) <- toIO (body undefined)
    pure x


main :: IO ()
main = doctest ["src/Main.hs"]
