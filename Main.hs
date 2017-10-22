data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  }


data PizzaUpdate
  = AddTopping Topping


applyPizzaUpdate :: Pizza -> PizzaUpdate -> Pizza
applyPizzaUpdate pizza@(Pizza {..}) = \case
  AddTopping topping -> pizza { toppings = insert topping toppings }








