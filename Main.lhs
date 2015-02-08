
  A compilable representation (Anthony Cowley was using a
  tagless-final representation, but you get the idea):

> type Color = Float

> data Image = Const Color
>            | X | Y
>            | Phi | R
>            | Plus Image Image
>            | Minus Image Image
>            | Times Image Image
             | ...

> instance Num Image where
>   (+) = Plus

> eval :: Image -> (Float,Float) -> Color
> eval X   (x,y) = x
> eval Y   (x,y) = y
> eval Phi (x,y) = atan2 y x / pi
> eval R   (x,y) = sqrt (x*x + y*y)
> eval (Const v)     xy = v
> eval (Plus  p1 p2) xy = eval p1 xy + eval p2 xy
> eval (Minus p1 p2) xy = eval p1 xy - eval p2 xy
> eval (Times p1 p2) xy = eval p1 xy * eval p2 xy

























































































> main :: IO ()
> main = putStrLn "typechecks."
