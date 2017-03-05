{-# LANGUAGE RankNTypes #-}


type Setter' s   a   = (a -> a) -> (s -> s)
type Setter  s t a b = (a -> b) -> (s -> t)

type FGH a = F (G (H a))
type  GH a =    G (H a)

--  FGH a -> FGH b
--        |
--        | GH a -> GH b
--        |      |
--        |      |  H a -> H b
--        |      |      |
--        v      v      v
-- fffmap = fmap . fmap . fmap :: (a -> b) -> (FGH a -> FGH b)

























































data F a
data G a
data H a

main :: IO ()
main = putStrLn "done."
