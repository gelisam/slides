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
