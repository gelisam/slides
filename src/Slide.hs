module Slide where

handleGetPowerStates :: Key Deployment -> Handler ()
handleGetPowerStates deploymentKey = do
  forkIO $ do  -- expected IO (Map ...), got m (Map ...)
    r <- getPowerStates deploymentKey
    print r

forkIO :: IO a -> IO ThreadId

getPowerStates :: ( MonadBuilder m
                  , MonadDataServer m
                  , MonadError Text m
                  , MonadHypervisor m
                  , MonadLogger m
                  , MonadTraced m
                  )
               => Key Deployment -> m (Map VmInstanceKey PowerState)
























































































main :: IO ()
main = putStrLn "typechecks."
