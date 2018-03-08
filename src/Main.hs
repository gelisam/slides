module Main where
import Test.DocTest

import Control.Concurrent.Async.Lifted
import Control.Exception.Lifted
import Control.Monad.IO.Class
import Control.Monad.State
import Control.Monad.Writer

-- |
-- >>> execWriterT test1
-- ["abc","def"]
test1 :: WriterT [String] IO ()
test1 = mapConcurrently_ tell [["abc"], ["def"]]

-- |
-- >>> execStateT test2 "foo"
-- "foo"
test2 :: StateT String IO ()
test2 = mapConcurrently_ modify [(++"!"), (++"?")]

-- |
-- >>> execWriterT test3
-- ...
test3 :: WriterT [String] IO ()
test3 = tell ["abc"] `finally` tell ["def"]

-- |
-- >>> execStateT test4 "foo"
-- ...
test4 :: StateT String IO ()
test4 = modify (++"!") `finally` modify (++"?")

-- |
-- >>> execStateT test5 "foo"
-- ...
-- ...
test5 :: StateT String IO ()
test5 = modify (++"!") `finally` do
  s <- get
  liftIO $ print s


main :: IO ()
main = doctest ["src/Main.hs"]
