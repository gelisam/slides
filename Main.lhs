

  Conal Elliott's composable representation:

> type Color = Float

> newtype Image a = Image {
>   runImage :: (Float,Float) -> a
> }

> instance Num a => Num (Image a) where
>   Image xs + Image ys = Image zs
>     where
>       zs ij = xs ij + ys ij




























































































> main :: IO ()
> main = putStrLn "typechecks."
