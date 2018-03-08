module Main where
import Test.DocTest

import Control.Monad.IO.Class
import Control.Monad.State

-- |
-- >>> openFile "myfile"
-- opening myfile
openFile :: FilePath -> IO ()
openFile filePath = putStrLn ("opening " ++ filePath)

-- |
-- >>> flip execStateT "foo" $ liftedOpenFile "myfile"
-- opening myfile
-- "foo"
liftedOpenFile :: MonadIO m => FilePath -> m ()
liftedOpenFile = liftIO    -- IO ()    -> m ()
               . openFile  -- FilePath -> IO ()


main :: IO ()
main = doctest ["src/Main.hs"]
