failing without an error message

> import Control.Applicative
> import Data.Char
> import Text.Read
> import Text.Trifecta

> bool :: Parser Bool
> bool = do s <- many (satisfy isAlpha)
>           case readMaybe s of
>             Just b -> pure b
>             Nothing -> empty <?> "boolean"










































> list :: Parser a -> Parser [a]
> list element = between (char '[') (char ']')
>              $ sepBy element (char ',')

> main :: IO ()
> main = do
>   parseTest (list bool) "[True,False,Purple,True]"
