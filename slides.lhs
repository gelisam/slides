


From two "lectures" ago: implementing `liftMaybe`.

> newtype Wrapper a = Wrapper {
>     runWrapper :: IO (Maybe a)
> }

> liftMaybe :: Maybe a -> Wrapper a
> liftMaybe mx = Wrapper _
