-- happy
{
module Main where
import Lexer
}

%name parse
%tokentype { Token }
%error { undefined }

%token 
  prefix { Prefix }
  suffix { Suffix }
  char   { Char $$ }

%%

Msg   : prefix Chars suffix { $2 }

Chars :                     { [] }
      | char Chars          { $1 : $2 }

{
main = print . parse . alexScanTokens =<< getContents
}
---

-- alex
{
module Lexer where
}

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
>   let [happy, alex,_] = wordsBy (== "---") source
>   writeFile "Lexer.x" (unlines alex)
>   writeFile "Parser.y" (unlines happy)
>   
>   _ <- system "alex Lexer.x"
>   _ <- system "happy Parser.y"
>   _ <- system (printf "echo %s | stack exec runhaskell Parser.hs" (show input))
>   pure ()
