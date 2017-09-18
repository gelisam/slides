> import Data.List.Extra

> input :: String
> input =                                                                                                                                            "Expected \"ok\" in [\"err\": true, \"message\": \"file \\\"foo.txt\\\" not found\"]"

      Expected "ok" in ["err": true, "message": "file \"foo.txt\" not found"]

> output :: Maybe String
> output = do
>     input' <- stripPrefix "Expected \"ok\" in [\"err\": true, \"message\": \"" input
>     input'' <- stripSuffix "\"]" input'
>     go input''
>   where
>     go :: [Char] -> Maybe [Char]
>     go []             = Just []
>     go ('\\':'"' :xs) = ('"':) <$> go xs
>     go ('\\':'\\':xs) = ('"':) <$> go xs
>     go ('\\':_)       = Nothing  -- unrecognized escape sequence
>     go (x:xs)         = (x:) <$> go xs






















































> main :: IO ()
> main = do
>   print output
