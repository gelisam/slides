{-# LANGUAGE ExistentialQuantification, RankNTypes, TemplateHaskell #-}
module Main where
import Test.DocTest

import Control.Lens


data Object
  = ObjectGraphicsCard      GraphicsCard
  | ObjectNetworkCardBrand1 NetworkCardBrand1
  | ObjectNetworkCardBrand2 NetworkCardBrand2
  | ObjectNetworkCardBrand3 NetworkCardBrand3
  | ObjectPrinter           Printer
  deriving Show

data GraphicsCard      = GraphicsCard                         deriving Show
data NetworkCardBrand1 = NetworkCardBrand1 Int                deriving Show
data NetworkCardBrand2 = NetworkCardBrand2 Int String         deriving Show
data NetworkCardBrand3 = NetworkCardBrand3 Int Double Double  deriving Show
data Printer           = Printer                              deriving Show

class HasMacAddress a where
  macAddress :: Lens' a Int

instance HasMacAddress NetworkCardBrand1 where
  macAddress f (NetworkCardBrand1 x) = NetworkCardBrand1 <$> f x

instance HasMacAddress NetworkCardBrand2 where
  macAddress f (NetworkCardBrand2 x y) = (\x' -> NetworkCardBrand2 x' y) <$> f x

instance HasMacAddress NetworkCardBrand3 where
  macAddress f (NetworkCardBrand3 x y z) = (\x' -> NetworkCardBrand3 x' y z) <$> f x


data SomeNetworkCard = forall n. HasMacAddress n =>
  SomeNetworkCard
  { someNetworkCardNetworkCard :: n
  , someNetworkCardToObject    :: n -> Object
  }






































































































main :: IO ()
main = doctest ["src/Main.hs"]
