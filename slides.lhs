Typed Holes
---

Exercise: implement `liftMaybe`.

> newtype Wrapper a = Wrapper {
>     runWrapper :: IO (Maybe a)
> }

> liftMaybe :: Maybe a -> Wrapper a
> liftMaybe mx = Wrapper (return mx)







> main = putStrLn "typechecks."
