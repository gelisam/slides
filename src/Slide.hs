module Slide where




insertSpec   :: Spec -> DataServerT m (Key Spec)
retrieveSpec :: Key Spec -> DataServerT m Spec
-- ...


data DataServerT m a = DataServerT
  { unDataServerT :: ReaderT Url m a
  }

runDataServerT :: DataServerT m a
               -> Url -> m a

testDataServerT :: (MonadIO m, MonadMask m)
                => DataServerT m a -> m a









































































main :: IO ()
main = putStrLn "typechecks."
