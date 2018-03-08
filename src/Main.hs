module Main where
import Test.DocTest

import Control.Monad.IO.Class
import Control.Monad.State
import Control.Monad.Writer
import UnliftIO.Exception
import UnliftIO.Async

-- |
-- >>> execWriterT test1
-- error: no instance for (MonadUnliftIO WriterT w IO)
test1 :: WriterT [String] IO ()
test1 = mapConcurrently_ tell [["abc"], ["def"]]

-- |
-- >>> execStateT test2 "foo"
-- error: no instance for (MonadUnliftIO StateT s IO)
test2 :: StateT String IO ()
test2 = mapConcurrently_ modify [(++"!"), (++"?")]

-- |
-- >>> execWriterT test3
-- error: no instance for (MonadUnliftIO WriterT w IO)
test3 :: WriterT [String] IO ()
test3 = tell ["abc"] `finally` tell ["def"]

-- |
-- >>> execStateT test4 "foo"
-- error: no instance for (MonadUnliftIO StateT s IO)
test4 :: StateT String IO ()
test4 = modify (++"!") `finally` modify (++"?")

-- |
-- >>> execStateT test5 "foo"
-- error: no instance for (MonadUnliftIO StateT s IO)
test5 :: StateT String IO ()
test5 = modify (++"!") `finally` do
  s <- get
  liftIO $ print s


main :: IO ()
main = doctest ["src/Main.hs"]
