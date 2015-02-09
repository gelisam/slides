
  Block... then freeze?

> import MyLVars
> import MyThreads

> main = do
>     var <- newLVar 0
>     threadA <- forkIO $ blockThenFreezeThenReadLVar var >>= print
>     threadB <- forkIO $ writeLVar var 1
>     threadC <- forkIO $ writeLVar var 2
>     
>     finalValue <- blockThenFreezeThenReadLVar var
>     print finalValue  -- Always 5?






































































