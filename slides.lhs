Nullary Type Classes
---

> {-# LANGUAGE NullaryTypeClasses, Rank2Types, FlexibleContexts #-}
> import Prelude hiding (log)
> import Unsafe.Coerce
> import System.IO.Unsafe


> data InitLog
> class YouHaventCalled e

> provideInit :: (YouHaventCalled InitLog => a) -> (() -> a)
> provideInit = unsafeCoerce

> log :: YouHaventCalled InitLog => String -> a -> a
> log msg x = unsafePerformIO $ do
>     -- imagine this was an ffi call to some logging library
>     putStrLn msg
>     return x

> initLog :: (YouHaventCalled InitLog => a) -> a
> initLog x = unsafePerformIO $ do
>     -- imagine this was initializing the logging library
>     putStrLn "init"
>     return (provideInit x ())


> test :: YouHaventCalled InitLog => Int
> test = log "left" 2 + log "right" 3

> -- No instance for YouHaventCalled
> main = print test
