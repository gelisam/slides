greedy vs non-greedy







greedy    :: Parser a -> Parser [a]
nonGreedy :: Parser a -> Parser [a]

a :: Parser Char
b :: Parser Char


parse (greedy    a <* b) "aaab" = Right "aaa"
parse (nonGreedy a <* b) "aaab" = Right "aaa"

parse (greedy    a <* many a <* b) "aaab" = Right "aaa"
parse (nonGreedy a <* many a <* b) "aaab" = Right ""












































> main :: IO ()
> main = do
>   putStrLn "typechecks."
