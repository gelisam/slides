{-# LANGUAGE ExistentialQuantification, RankNTypes #-}
module Main where
import Test.DocTest




data Object
  = ObjectGraphicsCard      GraphicsCard
  | ObjectNetworkCardBrand1 NetworkCardBrand1
  | ObjectNetworkCardBrand2 NetworkCardBrand2
  | ObjectNetworkCardBrand3 NetworkCardBrand3
  | ObjectPrinter           Printer

data GraphicsCard      = GraphicsCard
data NetworkCardBrand1 = NetworkCardBrand1
data NetworkCardBrand2 = NetworkCardBrand2
data NetworkCardBrand3 = NetworkCardBrand3
data Printer           = Printer






































































































main :: IO ()
main = doctest ["src/Main.hs"]
