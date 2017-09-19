
> import Text.Trifecta hiding (sepBy)
> import Text.Parser.Combinators

between       :: Applicative f => f open -> f close -> f a -> f a

sepBy         :: Alternative f => f a -> f sep -> f [a]
sepByNonEmpty :: Alternative f => f a -> f sep -> f (NonEmpty a)





> list :: Parser a -> Parser [a]
> list element = between (char '[') (char ']')
>              $ sepBy element (char ',')











































> main :: IO ()
> main = do
>   parseTest (list integer) "[1,2,3]"
