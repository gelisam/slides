

accessRequiredFor :: DocumentEdit -> Document -> Access
accessRequiredFor edit doc = writeAccessTo doc
























































data Document
data Access

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


main :: IO ()
main = putStrLn "done."
