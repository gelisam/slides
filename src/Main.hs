

accessRequiredFor :: DocumentEdit -> Document -> Access
accessRequiredFor edit doc = writeAccessTo doc
                          <> foldMap readAccessTo
                                     (documentsReferencedBy edit)

documentsReferencedBy :: DocumentEdit -> [Document]
documentsReferencedBy (EditImportList edit) = documentsReferencedBy' edit
documentsReferencedBy _                     = []

























































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


(<>) :: Monoid a => a -> a -> a
(<>) = mappend

instance Monoid Access where
  mempty = Access
  mappend Access Access = Access


main :: IO ()
main = putStrLn "done."
