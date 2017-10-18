data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  }

addExtra :: Topping -> Pizza -> Pizza
addExtra topping pizza@(Pizza {..}) = do
  pizza { extras = insert topping extras }

priceOrder :: Map Pizza Int -> Int
priceOrder order = [price pizza * count | (pizza, count) <- toList order]

pricePizza :: Pizza -> Int
pricePizza (Pizza {..}) = 10 + 2 * length extras







