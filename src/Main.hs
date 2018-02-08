{-# LANGUAGE ExistentialQuantification, RankNTypes #-}
module Main where
import Test.DocTest




data Object
  = ObjectGraphicsCard GraphicsCard
  | ObjectNetworkCard  NetworkCard
  | ObjectPrinter      Printer

data NetworkCard = NetworkCard
  { networkCardMacAddress        :: Int
  , networkCardBrandSpecificData :: BrandSpecificData
  }

data BrandSpecificData
  = BrandSpecificData1
  | BrandSpecificData2 String
  | BrandSpecificData3 Double Double

data GraphicsCard      = GraphicsCard
data Printer           = Printer






































































































main :: IO ()
main = doctest ["src/Main.hs"]
