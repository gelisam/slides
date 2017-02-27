

data Bash a b

ls     :: FilePath -> Bash a        [FilePath]
grep   :: RegExp   -> Bash [String] [String]

--sort :: Bash [String] [String]























data RegExp
ls   = undefined
grep = undefined
pure = undefined
save = undefined

arr :: (a -> b) -> Bash a b
arr = undefined






































main :: IO ()
main = putStrLn "done."
