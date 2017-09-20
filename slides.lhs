prioritized choice

> import Control.Applicative
> import Text.Trifecta hiding (sepBy)



> sepBy :: Parser a -> Parser sep -> Parser [a]
> sepBy element sep = go <|> pure []
>   where
>     go = ((:) <$> element <*> pure [])
>      <|> ((:) <$> element <*> (sep *> go))



> list :: Parser a -> Parser [a]
> list element = between (char '[') (char ']')
>              $ sepBy element (char ',')











































> main :: IO ()
> main = do
>   parseTest (list integer <* eof) "[1,2,3]"
