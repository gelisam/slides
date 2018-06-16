import Control.DeepSeq
import Test.DocTest

-- |
-- >>> :set +s
-- >>> rnf computation
computation :: Nested Int
computation = fmapN 1000 (+1) (makeNested 10000 0)

fmapN :: Functor f => Int -> (a -> a) -> f a -> f a
fmapN n f = fmap (composeN n f)

-- fmap ((+1) . (+1) . (+1))
























































data Nested a
  = Nest (Nested a)
  | Stop a

instance NFData a => NFData (Nested a) where
  rnf (Nest x) = rnf x
  rnf (Stop x) = rnf x

instance Functor Nested where
  fmap f (Nest nx) = Nest (fmap f nx)
  fmap f (Stop x)  = Stop (f x)

makeNested :: Int -> a -> Nested a
makeNested n x = composeN n Nest (Stop x)


composeN :: Int -> (a -> a) -> a -> a
composeN n f x = iterate f x !! n


main :: IO ()
main = doctest ["src/Main.hs"]
