
Samuel Gélineau

- Lambda Montréal
- Haskellers Montréal
- Used Haskell for personal projects since 2006

























































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
