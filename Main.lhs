
  Not deterministic:

> import Data.IORef
> import MyThreads

> main = do
>     ref <- newIORef 0
>     threadA <- forkIO $ writeIORef ref 1
>     threadB <- forkIO $ writeIORef ref 2
>     threadC <- forkIO $ writeIORef ref 3
>     
>     finalValue <- readIORef ref
>     print finalValue  -- 0, 1, 2, or 3?






































































