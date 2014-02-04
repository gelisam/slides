Type-level natural
---

> {-# LANGUAGE GADTs #-}



> data List a where
>   Nil :: List a
>   Cons :: a -> List a   -> List a









> main = putStrLn "typechecks"
