> {-# LANGUAGE GADTs #-}
> module MiniPan where

> import Control.Monad


> data MiniPan where
>   -- cartesian coordinates
>   X     :: MiniPan
>   Y     :: MiniPan

>   -- polar coordinates
>   Phi   :: MiniPan
>   R     :: MiniPan

>   -- numeric operations
>   Const :: Float -> MiniPan
>   Plus  :: MiniPan -> MiniPan -> MiniPan
>   Minus :: MiniPan -> MiniPan -> MiniPan
>   Times :: MiniPan -> MiniPan -> MiniPan
>   Div   :: MiniPan -> MiniPan -> MiniPan

>   -- comparison (1 for True, 0 for False)
>   Gt    :: MiniPan -> MiniPan -> MiniPan
>   Geq   :: MiniPan -> MiniPan -> MiniPan
>   Lt    :: MiniPan -> MiniPan -> MiniPan
>   Leq   :: MiniPan -> MiniPan -> MiniPan

>   -- 2D indexing: foo[x, y]
>   At    :: MiniPan -> (MiniPan, MiniPan) -> MiniPan

> char :: Float -> Char
> char x | x <= -0.75 = 'O'
>        | x <= -0.25 = 'o'
>        | x <=  0.25 = '.'
>        | x <=  0.75 = '+'
>        | otherwise  = '*'

> render :: (Int, Int) -> (Float -> Float -> Float) -> IO ()
> render (w,h) f = forM_ [0..h] $ \y -> do
>                    forM_ [0..w] $ \x -> do
>                      let v = f (adjustX x) (adjustY y)
>                      putChar (char v)
>                    putChar '\n'
>   where
>     adjustX x = 2 * (fromIntegral x / fromIntegral w - 0.5)
>     adjustY y = 2 * (0.5 - fromIntegral y / fromIntegral h)

> eval :: MiniPan -> Float -> Float -> Float
> eval X              x _ = x
> eval Y              _ y = y
> eval Phi            x y = atan2 y x / pi
> eval R              x y = sqrt (x*x + y*y)
> eval (Const v)      _ _ = v
> eval (Plus  p1 p2)  x y = eval p1 x y + eval p2 x y
> eval (Minus p1 p2)  x y = eval p1 x y - eval p2 x y
> eval (Times p1 p2)  x y = eval p1 x y * eval p2 x y
> eval (Div   p1 p2)  x y = eval p1 x y / eval p2 x y
> eval (Gt  p1 p2)    x y = if eval p1 x y >  eval p2 x y then 1 else 0
> eval (Geq p1 p2)    x y = if eval p1 x y >= eval p2 x y then 1 else 0
> eval (Lt  p1 p2)    x y = if eval p1 x y <  eval p2 x y then 1 else 0
> eval (Leq p1 p2)    x y = if eval p1 x y <= eval p2 x y then 1 else 0
> eval (At p (pX,pY)) x y = eval p (eval pX x y) (eval pY x y)

> instance Num MiniPan where
>   (+) = Plus
>   (-) = Minus
>   (*) = Times
>   signum p = 1 * (p `Gt` 0)
>            - 1 * (p `Lt` 0)
>   abs p = p * (p `Gt` 0)
>         - p * (p `Lt` 0)
>   fromInteger = Const . fromInteger

> instance Fractional MiniPan where
>   (/) = Div
>   fromRational = Const . fromRational

> renderPan :: MiniPan -> IO ()
> renderPan = render (40,20) . eval
































































