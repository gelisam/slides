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

---



















































> import Data.List.Extra
> import System.Process
> import Text.Printf

> input :: String
> input = "Expected \"ok\" in [\"err\": true, \"message\": \"file \\\"foo.txt\\\" not found\"]"

> main :: IO ()
> main = do
>   source <- lines <$> readFile "slides.lhs"
>   let [alex,_] = wordsBy (== "---") source
>   writeFile "Lexer.x" (unlines alex)
>   
>   _ <- system "alex Lexer.x"
>   _ <- system (printf "echo %s | stack exec runhaskell Lexer.hs" (show input))
>   pure ()
