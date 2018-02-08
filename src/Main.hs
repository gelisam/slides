{-# LANGUAGE ExistentialQuantification, RankNTypes #-}
module Main where
import Test.DocTest




data Object
  = ObjectGraphicsCard GraphicsCard
  | ObjectNetworkCard  NetworkCard
  | ObjectPrinter      Printer

data NetworkCard
  = NetworkCard1 NetworkCardBrand1
  | NetworkCard2 NetworkCardBrand2
  | NetworkCard3 NetworkCardBrand3

data GraphicsCard      = GraphicsCard
data NetworkCardBrand1 = NetworkCardBrand1 Int
data NetworkCardBrand2 = NetworkCardBrand2 Int String
data NetworkCardBrand3 = NetworkCardBrand3 Int Double Double
data Printer           = Printer






































































































main :: IO ()
main = doctest ["src/Main.hs"]
