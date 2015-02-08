> import Data.Array

  Non-composable representation:

> type Color = Float

> newtype Image = Image {
>   runImage :: Array (Int,Int) Color
> }

> instance Num Image where
>   Image xs + Image ys = Image zs
>     where
>       colorAt ij = (xs ! ij)
>                  + (ys ! ij)
>       wh = bounds xs
>       zs = array wh [(ij, colorAt ij) | ij <- range wh]




























































































> main :: IO ()
> main = putStrLn "typechecks."
