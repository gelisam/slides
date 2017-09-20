greedy vs non-greedy

> import Control.Applicative
> import Text.Trifecta


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
