{-# LANGUAGE FlexibleContexts, TemplateHaskell#-}
import Test.DocTest
import Control.Lens


traversal :: Traversal' [[a]] a
traversal = traversed . traversed

fold :: Fold [[a]] a
fold = traversed . folded






























































































main :: IO ()
main = doctest ["src/Main.hs"]
