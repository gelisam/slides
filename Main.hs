data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  }

instance Show Pizza where
  show (Pizza {..}) = "Pizza { toppings = " ++ show toppings
                         ++ ", extras   = " ++ show extras ++ " }"

instance Eq Pizza where
  p1 == p2 = (toppings p1 == toppings p2)
          && (extras   p1 == extras   p2)

instance Ord Pizza where
  p1 <= p2 = toppings p1 <= toppings p2
          && extras   p1 <= extras   p2

instance ToJSON Pizza where
  toJSON (Pizza {..}) = object [ "toppings" .= toppings
                               , "extras"   .= extras
                               ]
