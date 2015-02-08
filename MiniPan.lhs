> {-# LANGUAGE FlexibleInstances, GADTs, TypeSynonymInstances #-}
> module MiniPan where

> import Control.Monad
> import Language.C
> import Text.Printf


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


> cVar :: String -> CExpr
> cVar s = CVar (builtinIdent s) undefNode

> cPi :: CExpr
> cPi = cVar "M_PI"


> cCall :: String -> [CExpr] -> CExpr
> cCall funcName args = CCall (cVar funcName) args undefNode

> cAtan2 :: CExpr -> CExpr -> CExpr
> cAtan2 x y = cCall "atan2" [x,y]

> cSqrt :: CExpr -> CExpr
> cSqrt x = cCall "sqrt" [x]


> cOp :: CBinaryOp -> CExpr -> CExpr -> CExpr
> cOp op x y = CBinary op x y undefNode

> cGt, cGeq, cLt, cLeq :: CExpr -> CExpr -> CExpr
> cGt  = cOp CGrOp
> cGeq = cOp CGeqOp
> cLt  = cOp CLeOp
> cLeq = cOp CLeqOp


> fromFloat :: Float -> CExpr
> fromFloat n = CConst $ CFloatConst (cFloat n) undefNode

> instance Num CExpr where
>   (+) = cOp CAddOp
>   (-) = cOp CSubOp
>   (*) = cOp CMulOp
>   signum p = 1 * (p `cGt` 0)
>            - 1 * (p `cLt` 0)
>   abs p = p * (p `cGt` 0)
>         - p * (p `cLt` 0)
>   fromInteger = fromFloat . fromInteger

> instance Fractional CExpr where
>   (/) = cOp CDivOp
>   fromRational = fromFloat . fromRational

> compile :: MiniPan -> CExpr -> CExpr -> CExpr
> compile X              x _ = x
> compile Y              _ y = y
> compile Phi            x y = cAtan2 y x / cPi
> compile R              x y = cSqrt (x*x + y*y)
> compile (Const v)      _ _ = fromFloat v
> compile (Plus  p1 p2)  x y = compile p1 x y + compile p2 x y
> compile (Minus p1 p2)  x y = compile p1 x y - compile p2 x y
> compile (Times p1 p2)  x y = compile p1 x y * compile p2 x y
> compile (Div   p1 p2)  x y = compile p1 x y / compile p2 x y
> compile (Gt  p1 p2)    x y = compile p1 x y `cGt`  compile p2 x y
> compile (Geq p1 p2)    x y = compile p1 x y `cGeq` compile p2 x y
> compile (Lt  p1 p2)    x y = compile p1 x y `cLt`  compile p2 x y
> compile (Leq p1 p2)    x y = compile p1 x y `cLeq` compile p2 x y
> compile (At p (pX,pY)) x y = compile p (compile pX x y) (compile pY x y)

> compilePan :: MiniPan -> IO ()
> compilePan p = do
>     putStrLn "#include <math.h>"
>     putStrLn "#include <stdio.h>"
>     putStrLn ""
>     putStrLn "int main() {"
>     putStrLn "  int w = 40;"
>     putStrLn "  int h = 20;"
>     putStrLn "  for(int j=0; j<h; ++j) {"
>     putStrLn "    for(int i=0; i<w; ++i) {"
>     putStrLn "      float x = 2 * ((float)i / (float)w - 0.5);"
>     putStrLn "      float y = 2 * (0.5 - (float)j / (float)h);"
>     printf   "      float v = %s;\n" (show (pretty (compile p x y)))
>     putStrLn "      if      (v <= -0.75) printf(\"O\");"
>     putStrLn "      else if (v <= -0.25) printf(\"o\");"
>     putStrLn "      else if (v <=  0.25) printf(\".\");"
>     putStrLn "      else if (v <=  0.75) printf(\"+\");"
>     putStrLn "      else                 printf(\"*\");"
>     putStrLn "    }"
>     putStrLn "    printf(\"\\n\");"
>     putStrLn "  }"
>     putStrLn "  "
>     putStrLn "  return 0;"
>     putStrLn "}"
>   where
>     x = CVar (builtinIdent "x") undefNode
>     y = CVar (builtinIdent "y") undefNode




























































> main :: IO ()
> main = putStrLn "typechecks."
