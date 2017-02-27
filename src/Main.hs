
data Bash a b

ls    :: FilePath -> Bash a        [FilePath]
grep  :: RegExp   -> Bash [String] [String]
arr   :: (a -> b) -> Bash a        b







-- $ ls myfolder | ghc -e 'interact (unlines . reverse . lines)' | grep png
-- image2.png
-- image1.png

























data RegExp
ls    = undefined
grep  = undefined
arr   = undefined







































main :: IO ()
main = putStrLn "done."
