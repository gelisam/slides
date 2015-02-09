
  We get the error every time, so it's still deterministic

> import MyIVars
> import MyThreads

> main = do
>     var <- newIVar
>     threadA <- forkIO $ blockThenReadIVar var >>= print
>     threadB <- forkIO $ writeIVar var 41
>     threadC <- forkIO $ writeIVar var 42
>     
>     finalValue <- blockThenReadIVar var
>     print finalValue  -- ERROR: double-write






































































