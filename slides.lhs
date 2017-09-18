> import Data.List.Extra

> input :: String
> input =                                                                                                                                            "Expected \"ok\" in [\"err\": true, \"message\": \"file \\\"foo.txt\\\" not found\"]"

      Expected "ok" in ["err": true, "message": "file \"foo.txt\" not found"]

> output :: String
> output = wordsBy (== '\"') input !! 7






















































> main :: IO ()
> main = do
>   print output
