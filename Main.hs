-- type-safe diff for families of datatypes (gdiff)

data DataCtor
  -- Bool
  = TrueCtor     -- :: Bool
  | FalseCtor    -- :: Bool

  -- Maybe a
  | NothingCtor  -- :: Maybe a
  | JustCtor     -- :: a -> Maybe a

  -- (a, b)
  | PairCtor     -- :: a -> b -> (a, b)








