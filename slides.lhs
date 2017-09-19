> import Control.Applicative
> import Text.Trifecta

> bool :: Parser Bool
> bool = (True  <$ string "True")
>    <|> (False <$ string "False")

> tuple :: Parser a -> Parser b -> Parser (a, b)
> tuple parseA parseB = (,)
>                   <$> (char '(' *> parseA)
>                   <*> (char ',' *> parseB)
>                   <*   char ')'

> string_ :: Parser String
> string_ = char '"'
>        *> many stringChar
>       <*  char '"'

> stringChar :: Parser Char
> stringChar = satisfy (`notElem` ['\\', '\"'])
>          <|> (char '\\' *> char '\"')
>          <|> (char '\\' *> char '\\')













































> main :: IO ()
> main = do
>   putStrLn "typechecks."
