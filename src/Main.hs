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
--
-- >>> :{
-- mapM_ print $ over (each . _SomeNetworkCard . someNetworkCardMacAddress) (+100)
--   [ ObjectNetworkCardBrand1 (NetworkCardBrand1 1)
--   , ObjectNetworkCardBrand2 (NetworkCardBrand2 2 "foo")
--   , ObjectNetworkCardBrand3 (NetworkCardBrand3 3 1.5 4.2)
--   ]
-- :}
-- ObjectNetworkCardBrand1 (NetworkCardBrand1 101)
-- ObjectNetworkCardBrand2 (NetworkCardBrand2 102 "foo")
-- ObjectNetworkCardBrand3 (NetworkCardBrand3 103 1.5 4.2)
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
