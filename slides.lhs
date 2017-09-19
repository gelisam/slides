> {-# LANGUAGE OverloadedStrings #-}
> import Control.Applicative
> import Text.Trifecta


> parser :: Parser String
> parser = string "Expected \"ok\" in [\"err\": true, \"message\": \""
>       *> many stringChar
>       <* string "\"]"

> stringChar :: Parser Char
> stringChar = satisfy (`notElem` ['\\', '\"'])
>          <|> (char '\\' *> char '\"')
>          <|> (char '\\' *> char '\\')
















































> input :: String
> input = "Expected \"ok\" in [\"err\": true, \"message\": \"file \\\"foo.txt\\\" not found\\n\"]"

> main :: IO ()
> main = do
>   parseTest parser input
