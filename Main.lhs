
  An alternate view: freezing

> import MyIVars
> import MyThreads

> main = do
>     var <- newIVar
>     threadA <- forkIO $ blockThenReadIVar var >>= print
>     threadB <- forkIO $ writeThenFreezeIVar var 41
>     threadC <- forkIO $ writeThenFreezeIVar var 42
>     
>     finalValue <- blockThenReadIVar var
>     print finalValue  -- ERROR: write after freeze






































































