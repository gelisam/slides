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

data GraphicsCard      = GraphicsCard
data NetworkCardBrand1 = NetworkCardBrand1 Int
data NetworkCardBrand2 = NetworkCardBrand2 Int String
data NetworkCardBrand3 = NetworkCardBrand3 Int Double Double
data Printer           = Printer


data SomeNetworkCard = SomeNetworkCard
  { _someNetworkCardMacAddress :: Int
  , _someNetworkCardToObject   :: Int -> Object
  }

makeLenses ''SomeNetworkCard

-- |
-- >>> :{
-- toListOf (each . _SomeNetworkCard . someNetworkCardMacAddress)
--   [ ObjectNetworkCardBrand1 (NetworkCardBrand1 1)
--   , ObjectNetworkCardBrand2 (NetworkCardBrand2 2 "foo")
--   , ObjectNetworkCardBrand3 (NetworkCardBrand3 3 1.5 4.2)
--   ]
-- :}
-- [1,2,3]
_SomeNetworkCard :: Prism' Object SomeNetworkCard
_SomeNetworkCard = prism' unfocus focus
  where
    unfocus :: SomeNetworkCard -> Object
    unfocus (SomeNetworkCard i toObject) = toObject i

    focus :: Object -> Maybe SomeNetworkCard
    focus (ObjectNetworkCardBrand1 (NetworkCardBrand1 i    )) = Just $ SomeNetworkCard i $ \i' -> ObjectNetworkCardBrand1 $ NetworkCardBrand1 i'
    focus (ObjectNetworkCardBrand2 (NetworkCardBrand2 i x  )) = Just $ SomeNetworkCard i $ \i' -> ObjectNetworkCardBrand2 $ NetworkCardBrand2 i' x
    focus (ObjectNetworkCardBrand3 (NetworkCardBrand3 i x y)) = Just $ SomeNetworkCard i $ \i' -> ObjectNetworkCardBrand3 $ NetworkCardBrand3 i' x y
    focus _                                                   = Nothing






































































































main :: IO ()
main = doctest ["src/Main.hs"]
