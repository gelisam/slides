
  Who freezes?

> import MyIVars
> import MyThreads

> main = do
>     var <- newIVar
>     threadA <- forkIO $ freezeThenReadIVar var >>= print
>     threadB <- forkIO $ writeIVar var 41
>     threadC <- forkIO $ writeIVar var 42
>     
>     finalValue <- freezeThenReadIVar var
>     print finalValue  -- ERROR: write after freeze






































































