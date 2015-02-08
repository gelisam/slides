
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




























































































> main :: IO ()
> main = putStrLn "typechecks."
