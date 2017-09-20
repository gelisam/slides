greedy vs non-greedy

> import Control.Applicative
> import Text.Parser.Combinators
> import Text.Trifecta

> greedy :: Parser a -> Parser [a]
> greedy element = ((:) <$> element <*> greedy element)
>              <|> pure []

> nonGreedy :: Parser a -> Parser Char -> Parser [a]
> nonGreedy element next = ([] <$ followedBy next)
>                      <|> ((:) <$> element <*> nonGreedy element next)


parse (greedy    a   <* b) "aaab" = Right "aaa"
parse (nonGreedy a b <* b) "aaab" = Right "aaa"

parse (greedy    a           <* many a <* b) "aaab" = Right "aaa"
parse (nonGreedy a (a <|> b) <* many a <* b) "aaab" = Right ""






































> followedBy :: Parser a -> Parser ()
> followedBy next = do
>   isFollowedBy <- (False <$ notFollowedBy (() <$ next))
>               <|> pure True
>   if isFollowedBy then pure () else empty

> main :: IO ()
> main = do
>   putStr "greedy    a   <* b: "
>   parseTest (greedy    (char 'a') <* char 'b') "aaab"
>   putStr "nonGreedy a b <* b: "
>   parseTest (nonGreedy (char 'a') (char 'b') <* char 'b') "aaab"
>   
>   putStr "greedy    a           <* many a <* b: "
>   parseTest (greedy    (char 'a') <* many (char 'a') <* char 'b') "aaab"
>   putStr "nonGreedy a (a <|> b) <* many a <* b: "
>   parseTest (nonGreedy (char 'a') (char 'a' <|> char 'b') <* many (char 'a') <* char 'b') "aaab"
