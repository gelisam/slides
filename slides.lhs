greedy vs non-greedy

> import Control.Applicative

> data Parser a = Parser { runParser :: String -> [(String, a)] }

> greedy :: Parser a -> Parser [a]
> greedy element = ((:) <$> element <*> greedy element)
>              <|> pure []

> nonGreedy :: Parser a -> Parser [a]
> nonGreedy element = pure []
>                 <|> ((:) <$> element <*> nonGreedy element)


parse (greedy    a <* b) "aaab" = Right "aaa"
parse (nonGreedy a <* b) "aaab" = Right "aaa"

parse (greedy    a <* many a <* b) "aaab" = Right "aaa"
parse (nonGreedy a <* many a <* b) "aaab" = Right ""









































> instance Functor Parser where
>   fmap f = Parser . (fmap.fmap.fmap) f . runParser

> instance Applicative Parser where
>   pure x = Parser $ \s -> pure (s, x)
>   parserF <*> parserX = Parser $ \s0 -> do
>     (s1, f) <- runParser parserF s0
>     (s2, x) <- runParser parserX s1
>     pure (s2, f x)

> instance Alternative Parser where
>   empty = Parser $ \_ -> []
>   parser1 <|> parser2 = Parser $ \s
>                      -> runParser parser1 s
>                     <|> runParser parser2 s  

> char :: Char -> Parser Char
> char expected = Parser $ \s0 -> case s0 of
>   (actual:s1) | actual == expected -> pure (s1, actual)
>   _                                -> []

> parseTest :: Show a => Parser a -> String -> IO ()
> parseTest parser input = case runParser parser input of
>   (("",x):_) -> print x
>   _          -> putStrLn "no parse"

> main :: IO ()
> main = do
>   putStr "greedy    a <* b: "
>   parseTest (greedy    (char 'a') <* char 'b') "aaab"
>   putStr "nonGreedy a <* b: "
>   parseTest (nonGreedy (char 'a') <* char 'b') "aaab"
>   
>   putStr "greedy    a <* many a <* b: "
>   parseTest (greedy    (char 'a') <* many (char 'a') <* char 'b') "aaab"
>   putStr "nonGreedy a <* many a <* b: "
>   parseTest (nonGreedy (char 'a') <* many (char 'a') <* char 'b') "aaab"
