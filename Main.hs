class Diff a where
  type Patch a
  apply :: Patch a -> a -> a


Cons 1 (Cons 2 (Cons 3 Nil)) ==> Cons 1 (Cons 3 Nil)
       .----------- Keep ----------.                       Cpy ConsCtor
      /                             \                      Cpy 1
  1 ==> 1       Cons 2 (Cons 3 Nil) ==> Cons 3 Nil         Del ConsCtor
 no change             .------- Keep ------.          vs   Del 2
                      /                     \              Cpy ConsCtor
                  2 ==> 3        Cons 3 Nil ==> Nil        Cpy 3
                 Replace 3          Replace Nil            Cpy NilCtor








