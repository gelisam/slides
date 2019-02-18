module Slide where

data OneOf (hs :: [* -> *]) a where
  Here  :: h a        -> OneOf (h ': hs) a
  There :: OneOf hs a -> OneOf (h ': hs) a

data PutStrLnH a where PutStrLnH :: String -> PutStrLnH ()
data GetLineH  a where GetLineH  :: GetLineH String







putStrLnH :: String -> OneOf '[PutStrLnH, GetLineH] ()
putStrLnH s = Here (PutStrLnH s)

getLineH :: OneOf '[PutStrLnH, GetLineH] String
getLineH = There (Here GetLineH)


























































































data Freer g a where
  Purer  :: a -> Freer g a
  Deeper :: g x -> (x -> Freer g a) -> Freer g a


main :: IO ()
main = putStrLn "typechecks."
