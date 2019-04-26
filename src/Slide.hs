module Slide where

-- semantics-based

class Monad m => MonadDataServer m where
  insertSpec   :: Spec -> m (Key Spec)
  retrieveSpec :: Key Spec -> m Spec
  -- ...


data DataServerT m a = DataServerT
  { unDataServerT :: ReaderT Url m a
  }
instance MonadDataServer (DataServerT m)


















































































main :: IO ()
main = putStrLn "typechecks."
