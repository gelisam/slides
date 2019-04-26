module Slide where

-- implementation-based

class Monad m => MonadDataServer m where
  getDataServerUrl :: m Url

insertSpec   :: MonadDataServer m => Spec -> m (Key Spec)
retrieveSpec :: MonadDataServer m => Key Spec -> m Spec
-- ...


data DataServerT m a = DataServerT
  { unDataServerT :: ReaderT Url m a
  }
instance MonadDataServer (DataServerT m)











































































main :: IO ()
main = putStrLn "typechecks."
