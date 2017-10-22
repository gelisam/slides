data Pizza = Pizza
  { toppings :: Set Topping
  }

addTopping :: Topping -> Pizza -> Maybe Pizza
addTopping topping pizza@(Pizza {..}) = do
  guard (length toppings < 3)
  return $ pizza { toppings = insert topping toppings }

priceOrder :: Map Pizza Int -> Int
priceOrder order = [10 * count | (pizza, count) <- toList order]










