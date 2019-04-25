module Slide where

-- first-order effects

killThread :: ThreadId -> IO ()

readFile :: String -> IO String


-- higher-order effects

forkIO :: IO a -> IO ThreadId

withFile :: FilePath
         -> (Handle -> IO a)
         -> IO a
























































































main :: IO ()
main = putStrLn "typechecks."
