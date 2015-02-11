
  Associativity and Commutativity

> import Data.IORef
> import MyThreads

> main = do
>     ref <- newIORef 0
>     threadA <- forkIO $ atomicallyModify ref (+1)
>     threadB <- forkIO $ atomicallyModify ref (subtract 5)
>     threadC <- forkIO $ atomicallyModify ref (+10)
>     
>     finalValue <- readIORef ref
>     print finalValue


































































