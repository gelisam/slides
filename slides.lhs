Nullary Type Classes
---

> import Prelude hiding (log)
> import System.IO.Unsafe

> log :: String -> a -> a
> log msg x = unsafePerformIO $ do
>     putStrLn msg
>     return x


> main :: IO ()
> main = print (log "left" 2 + log "right" 3)
