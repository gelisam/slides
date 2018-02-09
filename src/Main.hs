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

_SomeNetworkCard :: Prism' Object SomeNetworkCard
_SomeNetworkCard = prism' unfocus focus
  where
    unfocus :: SomeNetworkCard -> Object
    unfocus (SomeNetworkCard n toObject) = toObject n

    focus :: Object -> Maybe SomeNetworkCard
    focus (ObjectNetworkCardBrand1 n) = Just $ SomeNetworkCard n ObjectNetworkCardBrand1
    focus (ObjectNetworkCardBrand2 n) = Just $ SomeNetworkCard n ObjectNetworkCardBrand2
    focus (ObjectNetworkCardBrand3 n) = Just $ SomeNetworkCard n ObjectNetworkCardBrand3
    focus _                           = Nothing

-- |
-- >>> :{
-- toListOf (each . _SomeNetworkCard . macAddress)
--   [ ObjectNetworkCardBrand1 (NetworkCardBrand1 1)
--   , ObjectNetworkCardBrand2 (NetworkCardBrand2 2 "foo")
--   , ObjectNetworkCardBrand3 (NetworkCardBrand3 3 1.5 4.2)
--   ]
-- :}
-- [1,2,3]
--
-- >>> :{
-- mapM_ print $ over (each . _SomeNetworkCard . macAddress) (+100)
--   [ ObjectNetworkCardBrand1 (NetworkCardBrand1 1)
--   , ObjectNetworkCardBrand2 (NetworkCardBrand2 2 "foo")
--   , ObjectNetworkCardBrand3 (NetworkCardBrand3 3 1.5 4.2)
--   ]
-- :}
-- ObjectNetworkCardBrand1 (NetworkCardBrand1 101)
-- ObjectNetworkCardBrand2 (NetworkCardBrand2 102 "foo")
-- ObjectNetworkCardBrand3 (NetworkCardBrand3 103 1.5 4.2)
instance HasMacAddress SomeNetworkCard where
  macAddress f (SomeNetworkCard n toObject) = (\n' -> SomeNetworkCard n' toObject) <$> macAddress f n





































































































main :: IO ()
main = doctest ["src/Main.hs"]
