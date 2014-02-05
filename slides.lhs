Introducing: Typed Holes!
---

Example: what is the type of `_1`?

> newtype Wrapper a = Wrapper {
>     runWrapper :: IO (Maybe a)
> }

> liftMaybe :: Maybe a -> Wrapper a
> liftMaybe mx = _1







> main = putStrLn "typechecks."
