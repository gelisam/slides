import qualified Data.List

data Bash a b

ls     :: FilePath -> Bash a        [FilePath]
grep   :: RegExp   -> Bash [String] [String]

sort   :: Bash [String] [String]
sort = arr Data.List.sort






















data RegExp
ls   = undefined
grep = undefined
pure = undefined
save = undefined

arr :: (a -> b) -> Bash a b
arr = undefined






































main :: IO ()
main = putStrLn "done."
