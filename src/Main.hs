{-# LANGUAGE FlexibleContexts, TemplateHaskell#-}
import Test.DocTest
import Control.Lens


-- |
-- >>> itoListOf indexedFold1 ["foo","bar"]
-- [(0,'f'),(0,'o'),(0,'o'),(1,'b'),(1,'a'),(1,'r')]
indexedFold1 :: IndexedFold Int [[a]] a
indexedFold1 = ifolded <. ifolded

-- |
-- >>> itoListOf indexedFold2 ["foo","bar"]
-- [(0,'f'),(1,'o'),(2,'o'),(0,'b'),(1,'a'),(2,'r')]
indexedFold2 :: IndexedFold Int [[a]] a
indexedFold2 = folded . ifolded






























































































main :: IO ()
main = doctest ["src/Main.hs"]
