Typed Holes
---

Exercise: implement `liftMaybe`.

> newtype Wrapper a = Wrapper {
>     runWrapper :: IO (Maybe a)
> }

> liftMaybe :: Maybe a -> Wrapper a
> liftMaybe mx = _







> main = putStrLn "typechecks."
