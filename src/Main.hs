

data Nested a
  = Nest (Nested a)
  | Stop a
  deriving Functor

makeNested :: Int -> a -> Nested a
makeNested n x = composeN n Nest (Stop x)


composeN :: Int -> (a -> a) -> a -> a
composeN n f x = iterate f x !! n




























































main :: IO ()
main = putStrLn "done."
