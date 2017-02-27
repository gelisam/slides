
data Bash a b

ls    :: FilePath -> Bash a        [FilePath]
grep  :: RegExp   -> Bash [String] [String]
arr   :: (a -> b) -> Bash a        b





-- $ mkfifo pure_input
-- $ mkfifo pure_output
-- $ ls myfolder | (cat > pure_input; cat pure_output) | grep png
-- image2.png
-- image1.png

























data RegExp
ls    = undefined
grep  = undefined
arr   = undefined







































main :: IO ()
main = putStrLn "done."
