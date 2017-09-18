




echo 'Expected "ok" in ["err": true, "message": "file not found"]' |
  cut -d'"' -f8























































exit 0

> import System.Process

> main :: IO ()
> main = do
>   _ <- system "bash slides.lhs"
>   pure ()
