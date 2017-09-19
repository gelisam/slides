separate lexing and parsing phase

> import Control.Monad
> import Text.Parsec

> bool :: Parsec [MyToken] () Bool
> bool = (True  <$ myToken TrueToken)
>    <|> (False <$ myToken FalseToken)

> list :: Parsec [MyToken] () a -> Parsec [MyToken] () [a]
> list element = between (myToken LBracketToken) (myToken RBracketToken)
>              $ sepBy element (myToken CommaToken)

> myTokens :: Parsec [Char] () [MyToken]
> myTokens = flip sepBy (many (char ' ')) $ (TrueToken     <$ string "True")
>                                       <|> (FalseToken    <$ string "False")
>                                       <|> (LBracketToken <$ char '[')
>                                       <|> (RBracketToken <$ char ']')
>                                       <|> (CommaToken    <$ char ',')

> lexAndParse :: Parsec [Char]  () [token]
              -> Parsec [token] () a
              -> String -> Either ParseError a
> lexAndParse lexer parser = parse lexer  "interactive"
>                        >=> parse parser "interactive"


































> data MyToken
>   = TrueToken
>   | FalseToken
>   | LBracketToken
>   | RBracketToken
>   | CommaToken
>   deriving (Show, Eq, Ord)

> myToken :: MyToken -> Parsec [MyToken] () MyToken
> myToken expected = try $ do
>   actual <- anyToken
>   if actual == expected
>   then pure actual
>   else parserFail $ "found " ++ show actual ++ ", expected " ++ show expected

> main :: IO ()
> main = do
>   case lexAndParse myTokens (list bool) "[True, False, True]" of
>     Left  e -> print
>     Right x -> print x
