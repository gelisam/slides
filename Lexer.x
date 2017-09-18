-- alex

%wrapper "basic"

tokens :-

  Expected\ \"ok\"\ in\ \[\"err\"\:\ true\,\ \"message\"\:\ \"  { \s -> Prefix }
  \"\]\n                                                        { \s -> Suffix }
  [^\\\"]                                                       { \(c:[]) -> Char c }
  \\ \\                                                         { \_ -> Char '\\' }
  \\ \"                                                         { \_ -> Char '\"' }

{
data Token
  = Prefix
  | Suffix
  | Char Char
  deriving (Eq,Show)

main = mapM_ print . alexScanTokens =<< getContents
}

