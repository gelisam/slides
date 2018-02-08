{-# LANGUAGE RankNTypes #-}
module Main where
import Test.DocTest

import Control.Lens


data AndOr a b = OnlyLeft a | OnlyRight b | Both a b

_Only :: Prism' (AndOr a b) (Either a b)
_Only = prism' unfocus focus
  where
    unfocus :: Either a b -> AndOr a b
    unfocus (Left  x) = OnlyLeft  x
    unfocus (Right y) = OnlyRight y

    focus :: AndOr a b -> Maybe (Either a b)
    focus (OnlyLeft  x) = Just $ Left  x
    focus (OnlyRight y) = Just $ Right y
    focus (Both _ _)    = Nothing






































































































main :: IO ()
main = doctest ["src/Main.hs"]
