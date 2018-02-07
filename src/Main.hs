



                  +--------------+               Fold      Setter
                  |   actions    |                 ^         ^
      +-----------+--------------+                 |_________|
      | Setter    |        set n |                      |
      | Fold      | get n        |        Getter    Traversal     
      | Getter    | get 1        |          ^           ^         
      | Traversal | get n  set n |          |___________|
      | Lens      | get 1  set 1 |                |
      +-----------+--------------+               Lens


















































data Const m a = Const m
data Identity a = Identity { runIdentity :: a }

instance Functor Identity where
  fmap f (Identity x) = Identity (f x)

instance Applicative Identity where
  pure x = Identity x
  Identity f <*> Identity x = Identity (f x)


main :: IO ()
main = putStrLn "done."
