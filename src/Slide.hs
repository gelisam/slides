module Slide where

data OneOf (hs :: [* -> *]) a where
  Here  :: h a        -> OneOf (h ': hs) a
  There :: OneOf hs a -> OneOf (h ': hs) a

class Member h hs where
  theOne :: h a -> OneOf hs a

instance {-# OVERLAPPING #-} Member h (h ': hs) where
  theOne = Here

instance Member h hs => Member h (h' ': hs) where
  theOne = There . theOne

putStrLnH :: Member PutStrLnH hs => String -> OneOf hs ()
putStrLnH s = theOne (PutStrLnH s)

getLineH :: Member GetLineH hs => OneOf hs String
getLineH = theOne GetLineH


























































































data Freer g a where
  Purer  :: a -> Freer g a
  Deeper :: g x -> (x -> Freer g a) -> Freer g a

data PutStrLnH a where PutStrLnH :: String -> PutStrLnH ()
data GetLineH  a where GetLineH  :: GetLineH String


main :: IO ()
main = putStrLn "typechecks."
