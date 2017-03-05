{-# LANGUAGE RankNTypes #-}


type Setter' s a     = (a -> a) -> (s -> s)
type Setter  s a b t = (a -> b) -> (s -> t)

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
-- fffmap = fmap . fmap . fmap :: Setter (FGH a) a b (FGH b)
--        ^      ^      ^      ^
--        |      |      |      |
--  s = FGH a   GH a   H a     a ----.
--  t = FGH b   GH b   H b     b <---'

























































data F a
data G a
data H a

main :: IO ()
main = putStrLn "done."
