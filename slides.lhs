left recursion

> import Control.Applicative
> import Text.Trifecta hiding (sepBy)

> data SnocList a = Nil | Snoc (SnocList a) a deriving Show

> sepBy :: Parser a -> Parser sep -> Parser (SnocList a)
> sepBy element sep = go <|> pure Nil
>   where
>     go = (Snoc <$> go       <*> (sep *> element))
>      <|> (Snoc <$> pure Nil <*> element)



> list :: Parser a -> Parser (SnocList a)
> list element = between (char '[') (char ']')
>              $ sepBy element (char ',')









































> main :: IO ()
> main = do
>   --parseTest (list integer) "[1,2,3]"
> 
>   -- GHC is usually pretty good at detecting infinite loops,
>   -- but not this time (and also not in ghci)
>   putStrLn "<<loop>>"
