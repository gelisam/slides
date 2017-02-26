import Control.Category

class Category k => Arrow k where
  arr   :: (a -> b) -> k a b
  first :: k a b    -> k (a,r) (b,r)

second  :: Arrow k
        => k a b    -> k (l,a) (l,b)

(***) :: Arrow k => k a b -> k a' b' -> k (a,a') (b,b')
(&&&) :: Arrow k => k a b -> k a  b' -> k a      (b,b')

swap    :: Arrow k => k (a,b)     (b,a)
assoc   :: Arrow k => k (a,(b,c)) ((a,b),c)
unassoc :: Arrow k => k ((a,b),c) (a,(b,c))
-- ...


















second   = undefined

(***)    = undefined
(&&&)    = undefined

swap     = undefined
assoc    = undefined
unassoc  = undefined

































main :: IO ()
main = putStrLn "done."
