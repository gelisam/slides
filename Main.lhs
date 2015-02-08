

  Conal Elliott's composable representation:

> type Color = Float

> newtype Image = Image {
>   runImage :: (Float,Float) -> Color
> }

> instance Num Image where
>   Image xs + Image ys = Image zs
>     where
>       zs ij = xs ij + ys ij




























































































> main :: IO ()
> main = putStrLn "typechecks."
