-------------------------------------------------------------------------------
-- 1.3. Verify the program                                                   --
-------------------------------------------------------------------------------
import Prelude hiding (not, (||), (/=))
import Ersatz.Simple

expr :: MonadSAT s m => m Expr
expr = do
  x <- namedBit "x"
  y <- namedBit "y"
  let f = Func2 "xor" xor
  pure $ (f false false /= false)
      || (f (not x) y /= not (f x y))
      || (f x (not y) /= not (f x y))

main :: IO ()
main = findAssignment expr










xor :: Boolean b
    => b -> b -> b
xor x y = choose
  (choose false true y)
  (choose true false y)
  x
