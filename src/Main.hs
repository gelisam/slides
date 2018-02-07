{-# LANGUAGE InstanceSigs, RankNTypes #-}
import Data.Monoid

type Fold s a = forall m. Monoid m => (a -> m) -> (s -> m)

data DocumentEdit
  = EditImportList ImportListEdit
  | ...

importListEdits :: DocumentEdit -> [ImportListEdit]
importListEdits (EditImportList x) = [x]
importListEdits _                  = []

--              :: Fold DocumentEdit ImportListEdit
_EditImportList :: forall m. Monoid m
                => (ImportListEdit -> m)
                -> (DocumentEdit -> m)
_EditImportList f (EditImportList x) = f x
_EditImportList _ _                  = mempty



















































data Document = Document
data Access = Access

data ImportListEdit
  = AddImport Document
  | SomeOtherImportListEdit

readAccessTo :: Document -> Access
readAccessTo = undefined

writeAccessTo :: Document -> Access
writeAccessTo = undefined


main :: IO ()
main = putStrLn "done."
