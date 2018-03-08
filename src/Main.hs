module Main where
import Test.DocTest





-- |
-- >>> withFile "myfile" $ putStrLn "doing stuff with myfile"
-- opening myfile
-- doing stuff with myfile
-- closing myfile
withFile :: FilePath -> IO a -> IO a
withFile filePath body = do
  putStrLn ("opening " ++ filePath)
  x <- body
  putStrLn ("closing " ++ filePath)
  pure x


main :: IO ()
main = doctest ["src/Main.hs"]
