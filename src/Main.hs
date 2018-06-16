import Control.DeepSeq
import Test.DocTest

-- |
-- >>> :set +s
-- >>> rnf computation
computation :: Nested Int
computation = fmapN 1000 (+1) (makeNested 10000 0)

fmapN :: Functor f => Int -> (a -> a) -> f a -> f a
fmapN n f = composeN n (fmap f)

-- fmap (+1) . fmap (+1) . fmap (+1)

























































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


newtype Yoneda f a = Yoneda
  { unYoneda :: forall r. (a -> r) -> f r }

instance Functor (Yoneda f) where
  fmap :: (a -> b) -> Yoneda f a -> Yoneda f b
  fmap a2b ya = Yoneda $ \b2r
             -> unYoneda ya (b2r . a2b)

makeYoneda :: Functor f => f a -> Yoneda f a
makeYoneda fa = Yoneda (<$> fa) 

fromYoneda :: Yoneda f a -> f a
fromYoneda ya = unYoneda ya id


main :: IO ()
main = doctest ["-XInstanceSigs", "-XRankNTypes", "src/Main.hs"]
