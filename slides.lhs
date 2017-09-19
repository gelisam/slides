ignoring whitespace

> import Control.Applicative
> import Text.Trifecta

> bool :: Parser Bool
> bool = (True  <$ string "True")
>    <|> (False <$ string "False")

> list :: Parser a -> Parser [a]
> list element = between (char '[') (char ']')
>              $ sepBy element (char ',')










































> main :: IO ()
> main = do
>   parseTest (list bool) "[True, False, True]"
