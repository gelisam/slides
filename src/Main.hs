{-# LANGUAGE DeriveFunctor, RankNTypes, ScopedTypeVariables, TupleSections #-}
import Test.DocTest

import Control.Applicative
import Data.Monoid
import Data.Traversable


type IFrom b i a = a -> (i, b)
type ISetter s t i a b = (i -> a -> b)
                      -> (s -> t)
type IFold s i a = forall m. Monoid m
                => (i -> a -> m)
                -> (s -> m)
type ITraversal s t i a b = forall f. Applicative f
                         => (i -> a -> f b)
                         -> (s -> f t)

composeFromsWith :: (i -> j -> k)
                 -> IFrom c i b
                 -> IFrom b j a
                 -> IFrom c k a
composeFromsWith ij f g a = let (j,b) = g a
                                (i,c) = f b
                            in (ij i j, c)

composeSettersWith :: (i -> j -> k)
                   -> ISetter s t i u v
                   -> ISetter u v j a b
                   -> ISetter s t k a b
composeSettersWith ij stuv uvab f = stuv $ \i
                                 -> uvab $ \j
                                 -> f (ij i j)

composeFoldsWith :: (i -> j -> k)
                 -> IFold s i u
                 -> IFold u j a
                 -> IFold s k a
composeFoldsWith ij su ua f = su $ \i
                           -> ua $ \j
                           -> f (ij i j)

composeTraversalsWith :: (i -> j -> k)
                      -> ITraversal s t i u v
                      -> ITraversal u v j a b
                      -> ITraversal s t k a b
composeTraversalsWith ij stuv uvab f = stuv $ \i
                                    -> uvab $ \j
                                    -> f (ij i j)

ifolded :: IFold [a] Int a
ifolded f xs = mconcat . zipWith f [0..] $ xs

itraversed :: ITraversal [a] [b] Int a b
itraversed f xs = sequenceA . zipWith f [0..] $ xs

findIndexOf :: Eq a
            => IFold s i a
            -> (a -> Bool)
            -> s
            -> Maybe i
findIndexOf sa p = getFirst . sa go
  where
    go i a = if p a
             then First (Just i)
             else mempty


-- |
-- >>> example
-- Just (1,0)
example :: Maybe (Int, Int)
example = findIndexOf (composeFoldsWith (,) ifolded ifolded)
                      (== "fo")
                      [ ["f","b","b"]
                      , ["fo","ba","ba"]
                      , ["foo","bar","baz"]
                      ]



































































































main :: IO ()
main = doctest ["src/Main.hs"]
