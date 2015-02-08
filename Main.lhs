> import Text.Printf

  A compilable representation:

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

> type CExpr = String

> compile :: Image -> (CExpr,CExpr) -> CExpr
> compile X   (x,y) = x
> compile Y   (x,y) = y
> compile Phi (x,y) = printf "(atan2(%s,%s) / M_PI)" y x
> compile R   (x,y) = printf "sqrt(%s*%s + %s*%s)" x x y y
> compile (Const v)     xy = show v
> compile (Plus  p1 p2) xy = printf "(%s + %s)" (compile p1 xy) (compile p2 xy)
> compile (Minus p1 p2) xy = printf "(%s - %s)" (compile p1 xy) (compile p2 xy)
> compile (Times p1 p2) xy = printf "(%s * %s)" (compile p1 xy) (compile p2 xy)























































































> main :: IO ()
> main = putStrLn "typechecks."
