
  Freezing and quasi-determinism

> import MyLVars
> import MyThreads

> main = do
>     var <- newLVar 0
>     threadA <- forkIO $ freezeThenReadLVar var >>= print
>     threadB <- forkIO $ atomicallyModify var (subtract 5)
>     threadC <- forkIO $ atomicallyModify var (+10)
>     
>     finalValue <- freezeThenReadLVar var
>     print finalValue  -- 5 or ERROR: write after freeze






































































