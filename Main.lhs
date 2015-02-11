
  The lattice enforces commutative writes

> import MyLVars
> import MyThreads

> main = do
>     var <- newLVar 0
>     threadA <- forkIO $ blockThenFreezeThenReadLVar var >>= print
>     threadB <- forkIO $ atomicallyModify var (join 1)
>     threadC <- forkIO $ atomicallyModify var (join 2)
>     
>     finalValue <- blockThenFreezeThenReadLVar var
>     print finalValue  -- Always 5?






































































