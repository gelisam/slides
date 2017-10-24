data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  } deriving (Show, Eq, Ord, Generic)













instance ToJSON Pizza



