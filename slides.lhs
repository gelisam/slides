consuming characters commits to this alternative

> import Control.Applicative
> import Text.Trifecta hiding (sepBy)



> sepBy :: Parser a -> Parser sep -> Parser [a]
> sepBy element sep = go <|> pure []
>   where
>     go = ((:) <$> element <*> (sep *> go))
>      <|> ((:) <$> element <*> pure [])



> list :: Parser a -> Parser [a]
> list element = between (char '[') (char ']')
>              $ sepBy element (char ',')











































> main :: IO ()
> main = do
>   parseTest (list integer) "[1,2,3]"
