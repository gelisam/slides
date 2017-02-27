{-# LANGUAGE Arrows #-}
import Prelude hiding ((.), id)
import Control.Arrow
import Control.Category

--class Arrow k => ArrowApply k where
--  app :: k (k a b, a) b

--               (>>=) :: m a -> (a ->   m b) ->   m b
bind :: ArrowApply k => k u a -> (a -> k u b) -> k u b
bind kua f = proc u -> do
    a   <- kua   -< u
    kub <- arr f -< a
    b   <- app   -< (kub, u)
    returnA      -< b





























main :: IO ()
main = putStrLn "done."
