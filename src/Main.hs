import Control.Lens

accessRequiredFor :: DocumentEdit -> Document -> Access
accessRequiredFor edit doc = writeAccessTo doc
                          <> foldMap readAccessTo
                                     (documentsReferencedBy edit)

documentsReferencedBy :: DocumentEdit -> [Document]
documentsReferencedBy = toListOf (_EditImportList . _ImportListEdit . _Add)

_EditImportList :: Fold DocumentEdit ImportListEdit
_ImportListEdit :: Fold ImportListEdit (ListEdit Document)
_Add            :: Fold (ListEdit a) a



















































data Document = Document
data Access = Access

readAccessTo :: Document -> Access
readAccessTo = undefined

writeAccessTo :: Document -> Access
writeAccessTo = undefined


data DocumentEdit
  = EditImportList ImportListEdit
  | SomeOtherDocumentEdit

data ImportListEdit
  = AddImport Document
  | SomeOtherImportListEdit

noEffect :: (Contravariant f, Applicative f) => f a
noEffect = contramap (const ()) (pure ())

_EditImportList f (EditImportList x) = EditImportList <$> f x
_EditImportList _ _                  = noEffect

_AddImport f (AddImport x) = AddImport <$> f x
_AddImport _ _             = noEffect


(<>) :: Monoid a => a -> a -> a
(<>) = mappend

instance Monoid Access where
  mempty = Access
  mappend Access Access = Access


main :: IO ()
main = putStrLn "done."
