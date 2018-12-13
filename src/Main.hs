{-# LANGUAGE FlexibleContexts, TemplateHaskell#-}
import Test.DocTest
import Control.Lens                                                                                                     hiding (folded)


indexedFold :: IndexedFold Int [[a]] a
indexedFold = ifolded . ifolded

fold :: Fold [[a]] a
fold = ifolded . folded





























































































folded :: Fold [a] a
folded = traverse

main :: IO ()
main = doctest ["src/Main.hs"]
