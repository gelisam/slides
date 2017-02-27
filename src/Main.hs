
data Bash a b

ls    :: FilePath -> Bash a        [FilePath]
grep  :: RegExp   -> Bash [String] [String]
arr   :: (a -> b) -> Bash a        b
(***) :: Bash a b
      -> Bash a' b'
      -> Bash (a,a') (b,b')


-- $ BOTH="foo,bar"
-- $ IN1="$(echo "$BOTH" | cut -d, -f1)"
-- $ IN2="$(echo "$BOTH" | cut -d, -f2)"
-- $ OUT1="$(echo -n "$IN1" | ghc -e 'interact reverse')"
-- $ OUT2="$(echo -n "$IN2" | ghc -e 'interact (map Data.Char.toUpper)')"
-- echo "$OUT1,$OUT2"
-- oof,BAR






















data RegExp
ls    = undefined
grep  = undefined
arr   = undefined
(***) = undefined







































main :: IO ()
main = putStrLn "done."
