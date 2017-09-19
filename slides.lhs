> {-# LANGUAGE OverloadedStrings #-}
> import Text.Megaparsec
> import Text.Megaparsec.Text
> import Data.Text

> parser :: Parser String
> parser = string "Expected \"ok\" in [\"err\": true, \"message\": \""
>       *> many stringChar
>       <* string "\"]"

> stringChar :: Parser Char
> stringChar = satisfy (`notElem` ['\\', '\"'])
>          <|> (char '\\' *> char '\"')
>          <|> (char '\\' *> char '\\')
















































> input :: Text
> input = "Expected \"ok\" in [\"err\": true, \"message\": \"file \\\"foo.txt\\\" not found\\n\"]"

> main :: IO ()
> main = do
>   parseTest parser input
