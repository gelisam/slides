{-# LANGUAGE InstanceSigs, RankNTypes #-}
import Control.Comonad

type Getter s a = forall e. (a -> e) -> (s -> e)

getMap :: Comonad w => (a -> e) -> (w a -> e)
getMap f = f . extract


--    FGH a -> e
--          |
--          |   GH a -> e
--          |        |
--          |        |    H a -> e
--          |        |        |
--          v        v        v
-- gggetMap = getMap . getMap . getMap :: (a -> e) -> (FGH a -> e)
-- gggetMap = getMap . getMap . getMap :: Getter (FGH a) a
--          ^        ^        ^        ^
--          |        |        |        |
--        FGH a     GH a     H a       a  ----.
--            e        e       e       e  <---'

























































data F a
data G a
data H a

type FGH a = F (G (H a))
type  GH a =    G (H a)

main :: IO ()
main = putStrLn "done."
