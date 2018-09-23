module Main where  {- slide 2 of 7 -}
import UnliftIO.Exception                                                                                                                                                                        ; import Test.DocTest; import Control.Monad.Except; import Control.Monad.Reader; import Control.Monad.State

-- |
-- >>> runReaderT test1 "foo"
-- "foo"
test1 :: ReaderT String IO ()
test1 = pure () `finally` do { r <- ask; lift (print r) }

-- |
-- >>> execStateT test2 ""
-- error: no instance for (MonadUnliftIO StateT s IO)
--
test2 :: StateT String IO ()
test2 = put "foo" `finally` do { s <- get; lift (print s); put "bar" }

-- |
-- >>> runExceptT test3
-- error: no instance for (MonadUnliftIO ExceptT e IO)
test3 :: ExceptT String IO ()
test3 = pure () `finally` throwError "oops"






































































































main :: IO ()
main = doctest ["src/Main.hs"]
