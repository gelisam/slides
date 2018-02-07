
SimSpace

- Haskell!
- Remote (3 in Boston, 1 in Florida, 3 in California, 1 in Michigan, 1 in Montréal)
- Startup (3 years old)
























































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
