data EditScript :: [*] -> [*] -> * where
  Ins :: DataCtor  -- :: T1 -> T2 -> ... -> S
      -> EditScript ts (T1:T2:...:ts')
      -> EditScript ts (S:ts')
  Del :: DataCtor  -- :: T1 -> T2 -> ... -> S
      -> EditScript (T1:T2:...:ts) ts'
      -> EditScript (S:ts) ts'
  Cpy :: DataCtor  -- :: T1 -> T2 -> ... -> S
      -> EditScript (T1:T2:...:ts) (T1:T2:...:ts')
      -> EditScript (S:ts) (S:ts')
  End :: EditScript [] []

Maybe Bool: []  ==> (Bool, Bool ) : []
  Del JustCtor
Bool : []       ==> (Bool, Bool ) : []
  Ins PairCtor
Bool : []       ==> Bool : Bool  : []
  Cpy TrueCtor
[]              ==> Bool  : []
  Ins FalseCtor
[]              ==> []
