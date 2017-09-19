tokens consume following whitespace

> import Control.Applicative
> import Text.Trifecta

> bool :: Parser Bool
> bool = (True  <$ trueToken)
>    <|> (False <$ falseToken)

> list :: Parser a -> Parser [a]
> list element = between lbracketToken rbracketToken
>              $ sepBy element commaToken

> trueToken     = string "True"  <* many (char ' ')
> falseToken    = string "False" <* many (char ' ')
> lbracketToken = char '['       <* many (char ' ')
> rbracketToken = char ']'       <* many (char ' ')
> commaToken    = char ','       <* many (char ' ')





































> trueToken     :: Parser String
> falseToken    :: Parser String
> lbracketToken :: Parser Char
> rbracketToken :: Parser Char
> commaToken    :: Parser Char

> main :: IO ()
> main = do
>   parseTest (list bool) "[True, False, True]"
