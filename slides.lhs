Nullary Type Classes
---

> {-# LANGUAGE NullaryTypeClasses, Rank2Types #-}
> import Prelude hiding (log)
> import Unsafe.Coerce
> import System.IO.Unsafe


> class NeedsInit

> provideInit :: (NeedsInit => a) -> (() -> a)
> provideInit = unsafeCoerce

> log :: NeedsInit => String -> a -> a
> log msg x = unsafePerformIO $ do
>     -- imagine this was an ffi call to some logging library
>     putStrLn msg
>     return x

> initLog :: (NeedsInit => a) -> a
> initLog x = unsafePerformIO $ do
>     -- imagine this was initializing the logging library
>     putStrLn "init"
>     return (provideInit x ())


> test :: NeedsInit => Int
> test = log "left" 2 + log "right" 3

> -- No instance for NeedsInit
> main = print test
