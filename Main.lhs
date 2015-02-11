
  IVar allows limited interaction

> import MyIVars
> import MyThreads

> main = do
>     var <- newIVar
>     threadA <- forkIO $ blockThenReadIVar var >>= print
>     threadB <- forkIO $ putStrLn "not touching the IVar"
>     threadC <- forkIO $ writeIVar var 42
>     
>     finalValue <- blockThenReadIVar var
>     print finalValue  -- 42






































































