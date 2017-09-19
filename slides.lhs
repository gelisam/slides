import Range.Shared.Utils

> import Control.Applicative
> import Text.Trifecta hiding (sepBy)

> data SnocList a = Nil | Snoc (SnocList a) a deriving Show

> sepBy :: Parser a -> Parser sep -> Parser (SnocList a)
> sepBy element sep = go <|> pure Nil
>   where
>     go = leftRecursiveParser (Snoc Nil <$> element) $ \xs
>                           -> (Snoc xs  <$> (sep *> element))

> leftRecursiveParser :: Parser a -> (a -> Parser a) -> Parser a
> leftRecursiveParser nonRecursiveCases mkRecursiveCases = allCases nonRecursiveCases
>   where
>     -- Depth N+1 looks like depth N followed by more stuff. So if we can't parse
>     -- with depth N, give up early, thereby breaking the infinite recursion.
>     allCases smallCases = do
>       lhs <- smallCases
>       allCases (mkRecursiveCases lhs) <|> pure lhs






































> list :: Parser a -> Parser (SnocList a)
> list element = between (char '[') (char ']')
>              $ sepBy element (char ',')

> main :: IO ()
> main = do
>   parseTest (list integer) "[1,2,3]"
