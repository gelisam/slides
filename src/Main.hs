data Seq a
  = EmptyT
  | Single a
  | Deep Int (Digit a)
             (Seq (Node a))
             (Digit a)

data Digit a
  = One   a
  | Two   a a
  | Three a a a
  | Four  a a a a

data Node a
  = Node2 Int a a
  | Node3 Int a a a





























































main :: IO ()
main = putStrLn "done."
