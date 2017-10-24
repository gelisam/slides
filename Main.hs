data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  }

data DataCtor = PizzaCtor | ...


type PizzaUpdate = EditScript [Pizza] [Pizza]

applyPizzaUpdate :: Pizza -> PizzaUpdate -> Maybe Pizza
applyPizzaUpdate = genericApply









