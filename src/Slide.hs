module Slide where
import Test.DocTest
import Control.Arrow
import Data.List hiding (unfoldr)

fold :: forall t tF r. Functor tF
     => (t -> tF t) -> (tF r -> r) -> t -> r
fold project foldF = hylo project foldF

unfold :: forall s tF t. Functor tF
       => (s -> tF s) -> (tF t -> t) -> s -> t
unfold unfoldF embed = hylo unfoldF embed


-- unfoldr :: (s -> Maybe (a, s)) -> s -> [a]
unfoldr :: (s -> ListF a s) -> s -> List a
unfoldr unfoldF = unfold unfoldF $ \case
  NilF       -> Nil
  ConsF b bs -> Cons b bs


hylo :: forall s f r. Functor f
     => (s -> f s) -> (f r -> r) -> s -> r
hylo divide conquer = go where
  go :: s -> r
  go = divide >>> fmap go >>> conquer















































































data ListF a r
  = NilF
  | ConsF a r
  deriving Functor

data List a
  = Nil
  | Cons a (List a)


data SearchTreeF a r
  = LeafF
  | BranchF r a r
  deriving Functor

data SearchTree a
  = Leaf
  | Branch (SearchTree a) a (SearchTree a)


main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
