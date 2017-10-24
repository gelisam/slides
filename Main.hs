class Diff a where
  type Patch a
  apply :: Patch a -> a -> a


Cons 1 (Cons 2 (Cons 3 Nil)) ==> Cons 1 (Cons 3 Nil)
       .----------- Keep ----------.
      /                             \
  1 ==> 1       Cons 2 (Cons 3 Nil) ==> Cons 3 Nil
 no change             .------- Keep ------.
                      /                     \
                  2 ==> 3        Cons 3 Nil ==> Nil









