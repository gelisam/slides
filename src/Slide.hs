module Slide where

runMyFileTest :: IO ()
runMyFileTest = runGoldenTest $ do
  withFile "deployment-key.txt" $ \handle -> do
    deploymentKey <- hGetContents handle
    sendPayload $ Aeson.object
      [ "request"       .= Aeson.String "getPowerStates"
      , "deploymentKey" .= deploymentKey
      ]
























































































main :: IO ()
main = putStrLn "typechecks."
