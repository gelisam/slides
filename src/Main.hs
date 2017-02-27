
data Bash a b

ls    :: FilePath -> Bash a        [FilePath]
grep  :: RegExp   -> Bash [String] [String]








-- $ ls myfolder | grep png
-- image1.png
-- image2.png






















data RegExp
ls    = undefined
grep  = undefined








































main :: IO ()
main = putStrLn "done."
