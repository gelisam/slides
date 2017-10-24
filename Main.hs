data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  } deriving Generic

instance Show Pizza where
  show = genericShow


instance Eq Pizza where
  (==) = genericEq


instance Ord Pizza where
  (<=) = genericLeq


instance ToJSON Pizza where
  toJSON = genericToJSON


