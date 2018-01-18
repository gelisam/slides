{-# LANGUAGE InstanceSigs, RankNTypes #-}
import Prelude hiding (Foldable, toList)



instance Foldable G where
  toList :: G a -> [a]
  toList (G x1 x2) = [x1, x2]


--          expected: [GH a] -> H a
--          atual:     GH a  -> [a]
--                       |
--                  H a  | [GH a]
--                   |   |    |
--                   v   v    v
-- tttoList = toList . toList . toList :: FGH a -> [a]

























































data F a
data G a = G a a
data H a

type FGH a = F (G (H a))
type  GH a =    G (H a)

class Foldable f where
  toList :: f a -> [a]

main :: IO ()
main = putStrLn "done."
