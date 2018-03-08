module Main where
import Test.DocTest




-- |
-- >>> openFile "myfile"
-- opening myfile
openFile :: FilePath -> IO ()
openFile filePath = putStrLn ("opening " ++ filePath)


main :: IO ()
main = doctest ["src/Main.hs"]
