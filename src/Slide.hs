module Slide where

runMyFileTest :: IO ()
runMyFileTest = runGoldenTest $ do
  withFile "deployment-key.txt" $ \handle -> do
    deploymentKey <- hGetContents handle
    sendPayload $ Aeson.object
      [ "request"       .= Aeson.String "getPowerStates"
      , "deploymentKey" .= deploymentKey
      ]

withFile :: FilePath
         -> (Handle -> IO a)
         -> IO a

runGoldenTest :: ReaderT Connection
                   (StateT [Aeson.Value]
                     (WriterT [Aeson.Value]
                       IO)) a
              -> IO a
























































































main :: IO ()
main = putStrLn "typechecks."
