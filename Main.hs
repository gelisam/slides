data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  }

addExtra :: Topping -> Pizza -> Pizza
addExtra topping pizza@(Pizza {..}) = do
  pizza { extras = insert topping extras }

priceOrder :: Map Pizza Int -> Int
priceOrder order = [10 * count | (pizza, count) <- toList order]










