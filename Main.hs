data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  }

$(generateDataCtor [''Pizza, 'Set, ''Topping])


type PizzaUpdate = EditScript [Pizza] [Pizza]

applyPizzaUpdate :: Pizza -> PizzaUpdate -> Maybe Pizza
applyPizzaUpdate = genericApply









