
import Prelude hiding ((.), id)
import Control.Arrow
import Control.Category

--class Arrow k => ArrowApply k where
--  app :: k (k a b, a) b

--               (>>=) :: m a -> (a ->   m b) ->   m b
bind :: ArrowApply k => k u a -> (a -> k u b) -> k u b
          -- u
bind kua f = (kua &&& id)
          -- (a, u)
         >>> first (arr f)
          -- (k u b, u)
         >>> app
          -- b





























main :: IO ()
main = putStrLn "done."
